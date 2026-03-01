// Base class utilities
const SortUtil = {
  swap(array, i, j) {
    const temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  },
  isSorted(array) {
    for (let i = 1; i < array.length; i++) {
      if (array[i] < array[i - 1]) return false;
    }
    return true;
  },
  shuffle(array) {
    for (let i = 0; i < array.length; i++) {
      SortUtil.swap(array, i, SortUtil.rand(array.length));
    }
    return array;
  },
  rand(num) {
    return Math.floor(Math.random() * num);
  },
  makeArray(size) {
    const array = [];
    for (let i = 0; i < size; i++) array.push(i);
    return array;
  },
  vecswap(array, a, b, n) {
    for (let i = 0; i < n; i++, a++, b++) SortUtil.swap(array, a, b);
  },
  med3(a, i, j, k) {
    return (a[i] < a[j]
      ? (a[j] < a[k] ? j : a[i] > a[k] ? i : k)
      : (a[j] > a[k] ? j : a[i] < a[k] ? i : k));
  },
  medianOf3(array, left, right) {
    const center = Math.floor((left + right) / 2);
    if (array[left] > array[center]) SortUtil.swap(array, left, center);
    if (array[left] > array[right]) SortUtil.swap(array, left, right);
    if (array[center] > array[right]) SortUtil.swap(array, center, right);
    SortUtil.swap(array, center, right - 1);
    return array[right - 1];
  },
  partition(array, left, right) {
    const pivot = SortUtil.medianOf3(array, left, right);
    let leftPtr = left;
    let rightPtr = right - 1;
    while (true) {
      while (array[++leftPtr] < pivot);
      while (array[--rightPtr] > pivot);
      if (leftPtr >= rightPtr) break;
      else SortUtil.swap(array, leftPtr, rightPtr);
    }
    SortUtil.swap(array, leftPtr, right - 1);
    return leftPtr;
  },
  manualSort(array, left, right) {
    const size = right - left + 1;
    if (size <= 1) return;
    else if (size === 2) {
      if (array[left] > array[right]) SortUtil.swap(array, left, right);
    } else {
      if (array[left] > array[right - 1]) SortUtil.swap(array, left, right - 1);
      if (array[left] > array[right]) SortUtil.swap(array, left, right);
      if (array[right - 1] > array[right]) SortUtil.swap(array, right - 1, right);
    }
  },
  rotate(array, left, right) {
    const p = array[right];
    for (let i = right; i > left; i--) array[i] = array[i - 1];
    array[left] = p;
  },
  reverseRange(array, lo, hi) {
    hi--;
    while (lo < hi) {
      const t = array[lo];
      array[lo++] = array[hi];
      array[hi--] = t;
    }
  },
  makeHeap(array, num, end) {
    let count = 0;
    const next1 = num * 2 + 1;
    const next2 = num * 2 + 2;
    if (next1 < end) count += SortUtil.makeHeap(array, next1, end);
    if (next2 < end) count += SortUtil.makeHeap(array, next2, end);
    count += SortUtil.fixHeap(array, num, end);
    return count;
  },
  fixHeap(array, num, end) {
    let next = num;
    let max = array[num];
    const next1 = num * 2 + 1;
    const next2 = num * 2 + 2;
    if (next1 < end && max < array[next1]) {
      max = array[next1];
      next = next1;
    }
    if (next2 < end && max < array[next2]) {
      max = array[next2];
      next = next2;
    }
    if (num === next) return 2;
    else {
      SortUtil.swap(array, num, next);
      return SortUtil.fixHeap(array, next, end) + 2;
    }
  }
};

// ---- Sorting Algorithms ----

const SORTALGO = {};

SORTALGO["Bubble Sort"] = {
  sort(array) {
    const arrays = [];
    let count = 0;
    array = array.slice();
    arrays.push(array.slice());
    let i = array.length;
    while (i > 0) {
      let min = 0;
      for (let j = 1; j < i; j++) {
        count++;
        if (array[j - 1] > array[j]) {
          SortUtil.swap(array, j - 1, j);
          min = j;
        }
      }
      i = min;
      arrays.push(array.slice());
    }
    arrays.push(array.slice());
    arrays.push(count);
    return arrays;
  }
};

SORTALGO["Odd Even Sort"] = {
  sort(array) {
    const arrays = [];
    let count = 0;
    array = array.slice();
    arrays.push(array.slice());
    while (true) {
      let flag = 0;
      for (let i = 1; i < array.length; i += 2) {
        count++;
        if (array[i - 1] > array[i]) {
          SortUtil.swap(array, i - 1, i);
          flag = 1;
        }
      }
      for (let i = 2; i < array.length; i += 2) {
        count++;
        if (array[i - 1] > array[i]) {
          SortUtil.swap(array, i - 1, i);
          flag = 1;
        }
      }
      arrays.push(array.slice());
      if (flag === 0) break;
    }
    arrays.push(count);
    return arrays;
  }
};

SORTALGO["Shaker Sort"] = {
  sort(array) {
    const arrays = [];
    let count = 0;
    array = array.slice();
    arrays.push(array.slice());
    let upper = array.length;
    let lower = 0;
    while (true) {
      let temp = 0;
      for (let i = lower + 1; i < upper; i++) {
        count++;
        if (array[i - 1] > array[i]) {
          SortUtil.swap(array, i - 1, i);
          temp = i;
        }
      }
      upper = temp;
      arrays.push(array.slice());
      if (lower >= upper) break;
      for (let i = upper - 1; i > lower; i--) {
        count++;
        if (array[i - 1] > array[i]) {
          SortUtil.swap(array, i - 1, i);
          temp = i;
        }
      }
      lower = temp;
      arrays.push(array.slice());
      if (lower >= upper) break;
    }
    arrays.push(array.slice());
    arrays.push(count);
    return arrays;
  }
};

SORTALGO["Comb Sort"] = {
  sort(array) {
    const arrays = [];
    let count = 0;
    arrays.push(array.slice());
    array = array.slice();
    let h = Math.floor(array.length * 10 / 13);
    while (true) {
      let flag = 1;
      for (let i = 0; i + h < array.length; i++) {
        count++;
        if (array[i] > array[i + h]) {
          SortUtil.swap(array, i, i + h);
          flag = 0;
        }
      }
      arrays.push(array.slice());
      h = Math.floor(h * 10 / 13);
      if (h <= 1) {
        if (flag === 1) break;
        h = 1;
      }
      if (h === 9 || h === 10) h = 11;
    }
    arrays.push(array.slice());
    arrays.push(count);
    return arrays;
  }
};

SORTALGO["Shell Sort"] = {
  sort(array) {
    const arrays = [];
    let count = 0;
    arrays.push(array.slice());
    array = array.slice();
    let h = 1;
    while (3 * h + 1 < array.length) h = 3 * h + 1;
    while (h > 0) {
      for (let i = h; i < array.length; i++) {
        const temp = array[i];
        let j;
        for (j = i - h; j >= 0 && array[j] > temp; j -= h) array[j + h] = array[j];
        array[j + h] = temp;
        count += (i - j) / h;
      }
      h = Math.floor(h / 3);
      arrays.push(array.slice());
    }
    arrays.push(array.slice());
    arrays.push(count);
    return arrays;
  }
};

SORTALGO["Insertion Sort"] = {
  sort(array) {
    const arrays = [];
    let count = 0;
    array = array.slice();
    arrays.push(array.slice());
    for (let i = 1; i < array.length; i++) {
      const temp = array[i];
      let j;
      for (j = i - 1; j >= 0 && array[j] > temp; j--) array[j + 1] = array[j];
      array[j + 1] = temp;
      count += i - j;
      arrays.push(array.slice());
    }
    arrays.push(array.slice());
    arrays.push(count);
    return arrays;
  }
};

SORTALGO["Binary Sort"] = {
  sort(array) {
    const arrays = [];
    let count = 0;
    array = array.slice();
    arrays.push(array.slice());
    for (let i = 1; i < array.length; i++) {
      count += this._binaryInsert(array, i);
      arrays.push(array.slice());
    }
    arrays.push(array.slice());
    arrays.push(count);
    return arrays;
  },
  _binaryInsert(array, pos) {
    let count = 0;
    const pivot = array[pos];
    let left = 0;
    let right = pos;
    while (left < right) {
      count++;
      const mid = (left + right) >>> 1;
      if (pivot < array[mid]) right = mid;
      else left = mid + 1;
    }
    SortUtil.rotate(array, left, pos);
    return count;
  }
};

SORTALGO["Selection Sort"] = {
  sort(array) {
    const arrays = [];
    let count = 0;
    array = array.slice();
    arrays.push(array.slice());
    let i = 0;
    while (i < array.length) {
      let min = array[i];
      let argmin = i;
      for (let j = i + 1; j < array.length; j++) {
        count++;
        if (min > array[j]) {
          min = array[j];
          argmin = j;
        }
      }
      SortUtil.swap(array, i, argmin);
      arrays.push(array.slice());
      i++;
    }
    arrays.push(array.slice());
    arrays.push(count);
    return arrays;
  }
};

SORTALGO["Quick Sort"] = {
  sort(array) {
    array = array.slice();
    let count = 0;
    const arrays = [];
    const sorted = [];
    for (let i = 0; i < array.length; i++) sorted.push(false);
    arrays.push(array.slice());
    while (!SortUtil.isSorted(array)) {
      let start = 0;
      while (true) {
        while (start < array.length && sorted[array[start]]) start++;
        if (start === array.length) break;
        let end = start + 1;
        while (end < array.length && !sorted[array[end]]) end++;
        let temp = array.slice(start, end);
        temp = this._qsort(temp, temp[0], sorted, start);
        for (let i = start; i < end; i++) array[i] = temp[i - start];
        count += end - start - 1;
        start = end;
      }
      arrays.push(array.slice());
    }
    arrays.push(array.slice());
    arrays.push(count);
    return arrays;
  },
  _qsort(array, num, sorted, s) {
    const small = [];
    const same = [];
    const big = [];
    for (let i = 0; i < array.length; i++) {
      if (array[i] < num) small.push(array[i]);
      else if (array[i] === num) same.push(array[i]);
      else big.push(array[i]);
    }
    for (let i = 0; i < same.length; i++) sorted[s + small.length + i] = true;
    return small.concat(same).concat(big);
  }
};

SORTALGO["Modified Quick Sort"] = {
  sort(array) {
    array = array.slice();
    let count = 0;
    const arrays = [];
    arrays.push(array.slice());
    const queueLeft = [0];
    const queueRight = [array.length - 1];
    const queueDepth = [1];
    let dep = 0;
    while (queueLeft.length > 0) {
      const left = queueLeft.shift();
      const right = queueRight.shift();
      const cdep = queueDepth.shift();
      const size = right - left + 1;
      if (size <= 3) {
        SortUtil.manualSort(array, left, right);
        count += size;
      }
      if (size <= 3) {
        if (dep < cdep) {
          dep = cdep;
          arrays.push(array.slice());
        }
        continue;
      }
      const pivot = SortUtil.partition(array, left, right);
      count += right - left;
      if (left < pivot - 1) {
        queueLeft.push(left);
        queueRight.push(pivot - 1);
        queueDepth.push(cdep + 1);
      }
      if (pivot + 1 < right) {
        queueLeft.push(pivot + 1);
        queueRight.push(right);
        queueDepth.push(cdep + 1);
      }
      if (dep < cdep) {
        dep = cdep;
        arrays.push(array.slice());
      }
    }
    arrays.push(array.slice());
    arrays.push(count);
    return arrays;
  }
};

SORTALGO["Java Sort"] = {
  sort(array) {
    const arrays = [];
    let count = 0;
    array = array.slice();
    const queueOff = [0];
    const queueLen = [array.length];
    const queueDepth = [1];
    let dep = 0;
    while (queueOff.length > 0) {
      const cdep = queueDepth.shift();
      const off = queueOff.shift();
      const len = queueLen.shift();
      if (dep < cdep) {
        dep = cdep;
        arrays.push(array.slice());
      }
      if (len < 7) {
        for (let i = off; i < len + off; i++) {
          for (let j = i; j > off && array[j - 1] > array[j]; j--) {
            SortUtil.swap(array, j, j - 1);
            count++;
          }
        }
        arrays.push(array.slice());
        continue;
      }
      let m = off + (len >>> 1);
      let n, l, s;
      if (len > 7) {
        l = off;
        n = off + len - 1;
        if (len > 40) {
          s = Math.floor(len / 8);
          l = SortUtil.med3(array, l, l + s, l + 2 * s); count += 3;
          m = SortUtil.med3(array, m - s, m, m + s); count += 3;
          n = SortUtil.med3(array, n, n - s, n - 2 * s); count += 3;
        }
        m = SortUtil.med3(array, l, m, n); count += 3;
      }
      const v = array[m];
      let a = off, b = a, c = off + len - 1, d = c;
      while (true) {
        while (b <= c && array[b] <= v) {
          count++;
          if (array[b] === v) SortUtil.swap(array, a++, b);
          count++;
          b++;
        }
        while (c >= b && array[c] >= v) {
          count++;
          if (array[c] === v) SortUtil.swap(array, c, d--);
          count++;
          c--;
        }
        if (b > c) break;
        SortUtil.swap(array, b++, c--);
      }
      n = off + len;
      s = Math.min(a - off, b - a); SortUtil.vecswap(array, off, b - s, s);
      s = Math.min(d - c, n - d - 1); SortUtil.vecswap(array, b, n - s, s);
      if ((s = b - a) > 1) {
        queueOff.push(off);
        queueLen.push(s);
        queueDepth.push(cdep + 1);
      }
      if ((s = d - c) > 1) {
        queueOff.push(n - s);
        queueLen.push(s);
        queueDepth.push(cdep + 1);
      }
    }
    arrays.push(array.slice());
    arrays.push(count);
    return arrays;
  }
};

SORTALGO["Merge Sort"] = {
  sort(array) {
    array = array.slice();
    let count = 0;
    const arrays = [];
    const group = SortUtil.makeArray(array.length);
    arrays.push(array.slice());
    while (!SortUtil.isSorted(array)) {
      let start1 = 0;
      while (start1 < array.length) {
        const cg = group[start1];
        let end = start1 + 1;
        while (end < array.length && group[end] === cg) end++;
        const start2 = end;
        if (start2 === array.length) break;
        const ng = group[start2];
        while (end < array.length && group[end] === ng) {
          group[end] = cg;
          end++;
        }
        count += this._merge(array, start1, start2, end);
        start1 = end;
      }
      arrays.push(array.slice());
    }
    arrays.push(array.slice());
    arrays.push(count);
    return arrays;
  },
  _merge(array, s1, s2, t) {
    const temp = array.slice(s1, s2);
    let count = 0;
    let j = 0, k = s2;
    for (let i = s1; i < t && j < s2 - s1; i++) {
      count++;
      if (k >= t || temp[j] < array[k]) array[i] = temp[j++];
      else array[i] = array[k++];
    }
    return count;
  }
};

SORTALGO["Strand Sort"] = {
  sort(array) {
    array = array.slice();
    const arrays = [];
    let count = 0;
    arrays.push(array.slice());
    let remain = array.slice();
    let sorted = [];
    while (sorted.length < array.length) {
      const inc = [];
      const temp2 = [];
      let c = 0;
      count += remain.length;
      for (let i = 0; i < remain.length; i++) {
        if (c <= remain[i]) {
          c = remain[i];
          inc.push(remain[i]);
        } else {
          temp2.push(remain[i]);
        }
      }
      remain = temp2;
      let temp = [];
      while (true) {
        count++;
        if (inc.length === 0) {
          temp = temp.concat(sorted);
          break;
        } else if (sorted.length === 0) {
          temp = temp.concat(inc);
          break;
        } else if (inc[0] < sorted[0]) temp.push(inc.shift());
        else temp.push(sorted.shift());
      }
      sorted = temp;
      arrays.push(sorted.concat(remain));
    }
    arrays.push(sorted.slice());
    arrays.push(count);
    return arrays;
  }
};

SORTALGO["Heap Sort"] = {
  sort(array) {
    const arrays = [];
    let count = 0;
    array = array.slice();
    arrays.push(array.slice());
    count += SortUtil.makeHeap(array, 0, array.length);
    SortUtil.makeHeap(array, 0, array.length);
    arrays.push(array.slice());
    for (let i = array.length - 1; i > 0; i--) {
      SortUtil.swap(array, 0, i);
      count += SortUtil.fixHeap(array, 0, i);
      arrays.push(array.slice());
    }
    arrays.push(array.slice());
    arrays.push(count);
    return arrays;
  }
};

SORTALGO["Radix Sort"] = {
  sort(array) {
    const arrays = [];
    const base = 4;
    array = array.slice();
    arrays.push(array.slice());
    for (let i = 1; i < array.length; i *= base) {
      const temp = [];
      for (let j = 0; j < base; j++) temp[j] = [];
      for (let j = 0; j < array.length; j++) {
        const num = Math.floor(array[j] / i) % base;
        temp[num].push(array[j]);
      }
      array = [];
      for (let j = 0; j < base; j++) array = array.concat(temp[j]);
      arrays.push(array);
    }
    arrays.push(array);
    arrays.push(0);
    return arrays;
  }
};

SORTALGO["Bucket Sort"] = {
  sort(array) {
    const arrays = [];
    arrays.push(array.slice());
    const bucket = new Array(array.length);
    for (let i = 0; i < array.length; i++) bucket[i] = 0;
    for (let i = 0; i < array.length; i++) bucket[array[i]]++;
    array = [];
    for (let i = 0; i < bucket.length; i++) {
      for (let j = 0; j < bucket[i]; j++) array.push(i);
    }
    arrays.push(array);
    arrays.push(0);
    return arrays;
  }
};

SORTALGO["Stooge Sort"] = {
  sort(array) {
    const arrays = [];
    let count = 0;
    array = array.slice();
    const stackLeft = [0];
    const stackRight = [array.length - 1];
    arrays.push(array.slice());
    while (stackLeft.length > 0) {
      const left = stackLeft.pop();
      const right = stackRight.pop();
      if (array[left] > array[right]) {
        SortUtil.swap(array, left, right);
        arrays.push(array.slice());
      }
      count++;
      if (right - left <= 1) continue;
      const t = Math.floor((right - left + 1) / 3);
      stackLeft.push(left);
      stackRight.push(right - t);
      stackLeft.push(left + t);
      stackRight.push(right);
      stackLeft.push(left);
      stackRight.push(right - t);
    }
    arrays.push(array.slice());
    arrays.push(count);
    return arrays;
  }
};

SORTALGO["Bogo Sort"] = {
  sort(array) {
    const MAX = 3000;
    let count = array.length - 1;
    const arrays = [];
    array = array.slice();
    arrays.push(array.slice());
    while (count < MAX && !SortUtil.isSorted(array)) {
      count += array.length - 1;
      SortUtil.shuffle(array);
      arrays.push(array.slice());
    }
    arrays.push(array.slice());
    if (!SortUtil.isSorted(array)) arrays.push(">" + count);
    else arrays.push(count);
    return arrays;
  }
};

SORTALGO["Bozo Sort"] = {
  sort(array) {
    const MAX = 3000;
    let count = array.length - 1;
    const arrays = [];
    array = array.slice();
    arrays.push(array.slice());
    while (count < MAX && !SortUtil.isSorted(array)) {
      count += array.length - 1;
      SortUtil.swap(array, SortUtil.rand(array.length), SortUtil.rand(array.length));
      arrays.push(array.slice());
    }
    arrays.push(array.slice());
    if (!SortUtil.isSorted(array)) arrays.push(">" + count);
    else arrays.push(count);
    return arrays;
  }
};

SORTALGO["Goro Sort"] = {
  sort(array) {
    let count = array.length - 1;
    const arrays = [];
    array = array.slice();
    arrays.push(array.slice());
    while (!SortUtil.isSorted(array)) {
      const ns = [];
      for (let i = 0; i < array.length; i++) {
        if (array[i] !== i) ns.push(array[i]);
      }
      for (let i = 0; i < ns.length; i++) {
        SortUtil.swap(array, ns[i], ns[SortUtil.rand(ns.length)]);
      }
      count += ns.length - 1;
      arrays.push(array.slice());
    }
    arrays.push(array.slice());
    if (!SortUtil.isSorted(array)) arrays.push(">" + count);
    else arrays.push(count);
    return arrays;
  }
};
