
/*
 *
 * Cross browser Object.keys implementation
 *
 * This is suggested implementation from Mozilla for supporting browser that do not implement Object.keys
 * if object doesn't have .keys function
 * if(!Object.keys) Object.keys = function(o){
 *    if (o !== Object(o))
 *       throw new TypeError('Object.keys called on non-object');
 *    var ret=[],p;
 *    for(p in o) if(Object.prototype.hasOwnProperty.call(o,p)) ret.push(p);
 *    return ret;
 * }
 */
if (!Object.keys) {
  Object.keys = function(o) {
    var p, ret;
    if (o !== Object(o)) {
      throw new TypeError("Object.keys called on non-object");
    }
    ret = [];
    p = void 0;
    for (p in o) {
      if (Object.prototype.hasOwnProperty.call(o, p)) {
        ret.push(p);
      }
    }
    return ret;
  };
}

//# sourceMappingURL=object_keys.js.map
