// HSV to RGB conversion (replicates frocessing ColorHSV behavior)
function hsvToRgb(h, s, v) {
  h = ((h % 360) + 360) % 360;
  s = Math.max(0, Math.min(1, s));
  v = Math.max(0, Math.min(1, v));
  const c = v * s;
  const x = c * (1 - Math.abs((h / 60) % 2 - 1));
  const m = v - c;
  let r, g, b;
  if (h < 60)      { r = c; g = x; b = 0; }
  else if (h < 120) { r = x; g = c; b = 0; }
  else if (h < 180) { r = 0; g = c; b = x; }
  else if (h < 240) { r = 0; g = x; b = c; }
  else if (h < 300) { r = x; g = 0; b = c; }
  else              { r = c; g = 0; b = x; }
  return {
    r: Math.round((r + m) * 255),
    g: Math.round((g + m) * 255),
    b: Math.round((b + m) * 255)
  };
}

function getColor(num, size) {
  const hue = num * 270 / size;
  const rgb = hsvToRgb(hue, 0.7, 1);
  return `rgb(${rgb.r},${rgb.g},${rgb.b})`;
}

function getColorWithAlpha(num, size, alpha) {
  const hue = num * 270 / size;
  const rgb = hsvToRgb(hue, 0.7, 1);
  return `rgba(${rgb.r},${rgb.g},${rgb.b},${alpha})`;
}

// DOM elements
const canvas = document.getElementById('canvas');
const ctx = canvas.getContext('2d');
const cAlgorithm = document.getElementById('c_algorithm');
const cAutoshuffle = document.getElementById('c_autoshuffle');
const bShuffle = document.getElementById('b_shuffle');
const bReverse = document.getElementById('b_reverse');
const bSort = document.getElementById('b_sort');
const bSave = document.getElementById('b_save');
const hSize = document.getElementById('h_size');
const tSize = document.getElementById('t_size');
const hThickness = document.getElementById('h_thickness');
const hAlpha = document.getElementById('h_alpha');
const tCompared = document.getElementById('t_compared');

// State
let SIZE = 64;
let THICKNESS = 2;
let ALPHA = 0.8;
let iarray = [];
let h = 500.0 / (SIZE - 1);
let inputMode = 'random';

function schange() {
  SIZE = parseInt(hSize.value);
  THICKNESS = parseInt(hThickness.value);
  ALPHA = parseFloat(hAlpha.value);
  h = SIZE > 1 ? 500.0 / (SIZE - 1) : 500;
  tSize.value = String(SIZE);
}

function tchange() {
  let num = parseInt(tSize.value) || 1;
  if (num > 512) {
    tSize.value = '512';
    num = 512;
  }
  if (num < 1) {
    tSize.value = '1';
    num = 1;
  }
  hSize.value = num;
  makeInput();
}

function makeInput() {
  if (inputMode === 'random') randomize();
  else if (inputMode === 'reverse') reverseInit();
}

function randomize() {
  inputMode = 'random';
  schange();
  iarray = SortUtil.shuffle(SortUtil.makeArray(SIZE));
  clearCanvas();
  for (let i = 0; i < SIZE; i++) {
    const num = iarray[i];
    ctx.fillStyle = getColor(num, SIZE);
    ctx.beginPath();
    ctx.arc(0, i * h, THICKNESS / 2, 0, Math.PI * 2);
    ctx.fill();
  }
}

function reverseInit() {
  inputMode = 'reverse';
  schange();
  iarray = SortUtil.makeArray(SIZE).reverse();
  clearCanvas();
  for (let i = 0; i < SIZE; i++) {
    const num = iarray[i];
    ctx.fillStyle = getColor(num, SIZE);
    ctx.beginPath();
    ctx.arc(0, i * h, THICKNESS / 2, 0, Math.PI * 2);
    ctx.fill();
  }
}

function clearCanvas() {
  ctx.fillStyle = '#000000';
  ctx.fillRect(0, 0, canvas.width, canvas.height);
}

function doSort() {
  if (cAutoshuffle.checked) randomize();
  const str = cAlgorithm.value;
  const algo = SORTALGO[str];
  if (!algo) return;
  const arrays = algo.sort(iarray);
  draw(arrays);
}

function draw(arrays) {
  clearCanvas();
  const compared = arrays.pop();
  tCompared.textContent = 'elements:' + SIZE + '\ncompared:' + compared;
  if (arrays.length <= 1) return;
  const w = 500 / (arrays.length - 1);
  for (let i = 1; i < arrays.length; i++) {
    const inv = new Array(SIZE);
    for (let j = 0; j < SIZE; j++) inv[arrays[i][j]] = j;
    for (let j = 0; j < SIZE; j++) {
      const num = arrays[i - 1][j];
      ctx.strokeStyle = getColorWithAlpha(num, SIZE, ALPHA);
      ctx.lineWidth = THICKNESS;
      ctx.lineCap = 'round';
      ctx.beginPath();
      ctx.moveTo((i - 1) * w, j * h);
      ctx.lineTo(i * w, inv[arrays[i - 1][j]] * h);
      ctx.stroke();
    }
  }
}

function saveImage() {
  const link = document.createElement('a');
  const algoName = cAlgorithm.value;
  link.download = algoName + '_' + SIZE + '_' + inputMode + '.png';
  link.href = canvas.toDataURL('image/png');
  link.click();
}

// Event listeners
bShuffle.addEventListener('click', randomize);
bReverse.addEventListener('click', reverseInit);
bSort.addEventListener('click', doSort);
bSave.addEventListener('click', saveImage);

hSize.addEventListener('input', makeInput);
tSize.addEventListener('keydown', function(e) {
  if (e.key === 'Enter') tchange();
});
hThickness.addEventListener('input', function() { schange(); });
hAlpha.addEventListener('input', function() { schange(); });

// Initialize
randomize();
