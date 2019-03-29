/**
 * Created by Administrator on 2015/12/24.
 */
!
    function(a) {
        "function" == typeof define && define.amd ? define(["jquery"], a) : "object" == typeof exports ? module.exports = a : a(jQuery)
    }(function(a) {
        function b(b) {
            var g = b || window.event,
                h = i.call(arguments, 1),
                j = 0,
                l = 0,
                m = 0,
                n = 0,
                o = 0,
                p = 0;
            if (b = a.event.fix(g), b.type = "mousewheel", "detail" in g && (m = -1 * g.detail), "wheelDelta" in g && (m = g.wheelDelta), "wheelDeltaY" in g && (m = g.wheelDeltaY), "wheelDeltaX" in g && (l = -1 * g.wheelDeltaX), "axis" in g && g.axis === g.HORIZONTAL_AXIS && (l = -1 * m, m = 0), j = 0 === m ? l : m, "deltaY" in g && (m = -1 * g.deltaY, j = m), "deltaX" in g && (l = g.deltaX, 0 === m && (j = -1 * l)), 0 !== m || 0 !== l) {
                if (1 === g.deltaMode) {
                    var q = a.data(this, "mousewheel-line-height");
                    j *= q, m *= q, l *= q
                } else if (2 === g.deltaMode) {
                    var r = a.data(this, "mousewheel-page-height");
                    j *= r, m *= r, l *= r
                }
                if (n = Math.max(Math.abs(m), Math.abs(l)), (!f || f > n) && (f = n, d(g, n) && (f /= 40)), d(g, n) && (j /= 40, l /= 40, m /= 40), j = Math[j >= 1 ? "floor" : "ceil"](j / f), l = Math[l >= 1 ? "floor" : "ceil"](l / f), m = Math[m >= 1 ? "floor" : "ceil"](m / f), k.settings.normalizeOffset && this.getBoundingClientRect) {
                    var s = this.getBoundingClientRect();
                    o = b.clientX - s.left, p = b.clientY - s.top
                }
                return b.deltaX = l, b.deltaY = m, b.deltaFactor = f, b.offsetX = o, b.offsetY = p, b.deltaMode = 0, h.unshift(b, j, l, m), e && clearTimeout(e), e = setTimeout(c, 200), (a.event.dispatch || a.event.handle).apply(this, h)
            }
        }
        function c() {
            f = null
        }
        function d(a, b) {
            return k.settings.adjustOldDeltas && "mousewheel" === a.type && b % 120 === 0
        }
        var e, f, g = ["wheel", "mousewheel", "DOMMouseScroll", "MozMousePixelScroll"],
            h = "onwheel" in document || document.documentMode >= 9 ? ["wheel"] : ["mousewheel", "DomMouseScroll", "MozMousePixelScroll"],
            i = Array.prototype.slice;
        if (a.event.fixHooks) for (var j = g.length; j;) a.event.fixHooks[g[--j]] = a.event.mouseHooks;
        var k = a.event.special.mousewheel = {
            version: "3.1.12",
            setup: function() {
                if (this.addEventListener) for (var c = h.length; c;) this.addEventListener(h[--c], b, !1);
                else this.onmousewheel = b;
                a.data(this, "mousewheel-line-height", k.getLineHeight(this)), a.data(this, "mousewheel-page-height", k.getPageHeight(this))
            },
            teardown: function() {
                if (this.removeEventListener) for (var c = h.length; c;) this.removeEventListener(h[--c], b, !1);
                else this.onmousewheel = null;
                a.removeData(this, "mousewheel-line-height"), a.removeData(this, "mousewheel-page-height")
            },
            getLineHeight: function(b) {
                var c = a(b),
                    d = c["offsetParent" in a.fn ? "offsetParent" : "parent"]();
                return d.length || (d = a("body")), parseInt(d.css("fontSize"), 10) || parseInt(c.css("fontSize"), 10) || 16
            },
            getPageHeight: function(b) {
                return a(b).height()
            },
            settings: {
                adjustOldDeltas: !0,
                normalizeOffset: !0
            }
        };
        a.fn.extend({
            mousewheel: function(a) {
                return a ? this.bind("mousewheel", a) : this.trigger("mousewheel")
            },
            unmousewheel: function(a) {
                return this.unbind("mousewheel", a)
            }
        })
    });
(function(e) {
    var o = "left",
        n = "right",
        d = "up",
        v = "down",
        c = "in",
        w = "out",
        l = "none",
        r = "auto",
        k = "swipe",
        s = "pinch",
        x = "tap",
        i = "doubletap",
        b = "longtap",
        A = "horizontal",
        t = "vertical",
        h = "all",
        q = 10,
        f = "start",
        j = "move",
        g = "end",
        p = "cancel",
        a = "ontouchstart" in window,
        y = "TouchSwipe";
    var m = {
        fingers: 1,
        threshold: 75,
        cancelThreshold: null,
        pinchThreshold: 20,
        maxTimeThreshold: null,
        fingerReleaseThreshold: 250,
        longTapThreshold: 500,
        doubleTapThreshold: 200,
        swipe: null,
        swipeLeft: null,
        swipeRight: null,
        swipeUp: null,
        swipeDown: null,
        swipeStatus: null,
        pinchIn: null,
        pinchOut: null,
        pinchStatus: null,
        click: null,
        tap: null,
        doubleTap: null,
        longTap: null,
        triggerOnTouchEnd: true,
        triggerOnTouchLeave: false,
        allowPageScroll: "auto",
        fallbackToMouseEvents: true,
        excludedElements: "button, input, select, textarea, a, .noSwipe"
    };
    e.fn.swipe = function(D) {
        var C = e(this),
            B = C.data(y);
        if (B && typeof D === "string") {
            if (B[D]) {
                return B[D].apply(this, Array.prototype.slice.call(arguments, 1))
            } else {
                e.error("Method " + D + " does not exist on jQuery.swipe")
            }
        } else {
            if (!B && (typeof D === "object" || !D)) {
                return u.apply(this, arguments)
            }
        }
        return C
    };
    e.fn.swipe.defaults = m;
    e.fn.swipe.phases = {
        PHASE_START: f,
        PHASE_MOVE: j,
        PHASE_END: g,
        PHASE_CANCEL: p
    };
    e.fn.swipe.directions = {
        LEFT: o,
        RIGHT: n,
        UP: d,
        DOWN: v,
        IN: c,
        OUT: w
    };
    e.fn.swipe.pageScroll = {
        NONE: l,
        HORIZONTAL: A,
        VERTICAL: t,
        AUTO: r
    };
    e.fn.swipe.fingers = {
        ONE: 1,
        TWO: 2,
        THREE: 3,
        ALL: h
    };

    function u(B) {
        if (B && (B.allowPageScroll === undefined && (B.swipe !== undefined || B.swipeStatus !== undefined))) {
            B.allowPageScroll = l
        }
        if (B.click !== undefined && B.tap === undefined) {
            B.tap = B.click
        }
        if (!B) {
            B = {}
        }
        B = e.extend({}, e.fn.swipe.defaults, B);
        return this.each(function() {
            var D = e(this);
            var C = D.data(y);
            if (!C) {
                C = new z(this, B);
                D.data(y, C)
            }
        })
    }
    function z(a0, aq) {
        var av = (a || !aq.fallbackToMouseEvents),
            G = av ? "touchstart" : "mousedown",
            au = av ? "touchmove" : "mousemove",
            R = av ? "touchend" : "mouseup",
            P = av ? null : "mouseleave",
            az = "touchcancel";
        var ac = 0,
            aL = null,
            Y = 0,
            aX = 0,
            aV = 0,
            D = 1,
            am = 0,
            aF = 0,
            J = null;
        var aN = e(a0);
        var W = "start";
        var T = 0;
        var aM = null;
        var Q = 0,
            aY = 0,
            a1 = 0,
            aa = 0,
            K = 0;
        var aS = null;
        try {
            aN.bind(G, aJ);
            aN.bind(az, a5)
        } catch (ag) {
            e.error("events not supported " + G + "," + az + " on jQuery.swipe")
        }
        this.enable = function() {
            aN.bind(G, aJ);
            aN.bind(az, a5);
            return aN
        };
        this.disable = function() {
            aG();
            return aN
        };
        this.destroy = function() {
            aG();
            aN.data(y, null);
            return aN
        };
        this.option = function(a8, a7) {
            if (aq[a8] !== undefined) {
                if (a7 === undefined) {
                    return aq[a8]
                } else {
                    aq[a8] = a7
                }
            } else {
                e.error("Option " + a8 + " does not exist on jQuery.swipe.options")
            }
        };

        function aJ(a9) {
            if (ax()) {
                return
            }
            if (e(a9.target).closest(aq.excludedElements, aN).length > 0) {
                return
            }
            var ba = a9.originalEvent ? a9.originalEvent : a9;
            var a8, a7 = a ? ba.touches[0] : ba;
            W = f;
            if (a) {
                T = ba.touches.length
            } else {
                a9.preventDefault()
            }
            ac = 0;
            aL = null;
            aF = null;
            Y = 0;
            aX = 0;
            aV = 0;
            D = 1;
            am = 0;
            aM = af();
            J = X();
            O();
            if (!a || (T === aq.fingers || aq.fingers === h) || aT()) {
                ae(0, a7);
                Q = ao();
                if (T == 2) {
                    ae(1, ba.touches[1]);
                    aX = aV = ap(aM[0].start, aM[1].start)
                }
                if (aq.swipeStatus || aq.pinchStatus) {
                    a8 = L(ba, W)
                }
            } else {
                a8 = false
            }
            if (a8 === false) {
                W = p;
                L(ba, W);
                return a8
            } else {
                ak(true)
            }
        }
        function aZ(ba) {
            var bd = ba.originalEvent ? ba.originalEvent : ba;
            if (W === g || W === p || ai()) {
                return
            }
            var a9, a8 = a ? bd.touches[0] : bd;
            var bb = aD(a8);
            aY = ao();
            if (a) {
                T = bd.touches.length
            }
            W = j;
            if (T == 2) {
                if (aX == 0) {
                    ae(1, bd.touches[1]);
                    aX = aV = ap(aM[0].start, aM[1].start)
                } else {
                    aD(bd.touches[1]);
                    aV = ap(aM[0].end, aM[1].end);
                    aF = an(aM[0].end, aM[1].end)
                }
                D = a3(aX, aV);
                am = Math.abs(aX - aV)
            }
            if ((T === aq.fingers || aq.fingers === h) || !a || aT()) {
                aL = aH(bb.start, bb.end);
                ah(ba, aL);
                ac = aO(bb.start, bb.end);
                Y = aI();
                aE(aL, ac);
                if (aq.swipeStatus || aq.pinchStatus) {
                    a9 = L(bd, W)
                }
                if (!aq.triggerOnTouchEnd || aq.triggerOnTouchLeave) {
                    var a7 = true;
                    if (aq.triggerOnTouchLeave) {
                        var bc = aU(this);
                        a7 = B(bb.end, bc)
                    }
                    if (!aq.triggerOnTouchEnd && a7) {
                        W = ay(j)
                    } else {
                        if (aq.triggerOnTouchLeave && !a7) {
                            W = ay(g)
                        }
                    }
                    if (W == p || W == g) {
                        L(bd, W)
                    }
                }
            } else {
                W = p;
                L(bd, W)
            }
            if (a9 === false) {
                W = p;
                L(bd, W)
            }
        }
        function I(a7) {
            var a8 = a7.originalEvent;
            if (a) {
                if (a8.touches.length > 0) {
                    C();
                    return true
                }
            }
            if (ai()) {
                T = aa
            }
            a7.preventDefault();
            aY = ao();
            Y = aI();
            if (a6()) {
                W = p;
                L(a8, W)
            } else {
                if (aq.triggerOnTouchEnd || (aq.triggerOnTouchEnd == false && W === j)) {
                    W = g;
                    L(a8, W)
                } else {
                    if (!aq.triggerOnTouchEnd && a2()) {
                        W = g;
                        aB(a8, W, x)
                    } else {
                        if (W === j) {
                            W = p;
                            L(a8, W)
                        }
                    }
                }
            }
            ak(false)
        }
        function a5() {
            T = 0;
            aY = 0;
            Q = 0;
            aX = 0;
            aV = 0;
            D = 1;
            O();
            ak(false)
        }
        function H(a7) {
            var a8 = a7.originalEvent;
            if (aq.triggerOnTouchLeave) {
                W = ay(g);
                L(a8, W)
            }
        }
        function aG() {
            aN.unbind(G, aJ);
            aN.unbind(az, a5);
            aN.unbind(au, aZ);
            aN.unbind(R, I);
            if (P) {
                aN.unbind(P, H)
            }
            ak(false)
        }
        function ay(bb) {
            var ba = bb;
            var a9 = aw();
            var a8 = aj();
            var a7 = a6();
            if (!a9 || a7) {
                ba = p
            } else {
                if (a8 && bb == j && (!aq.triggerOnTouchEnd || aq.triggerOnTouchLeave)) {
                    ba = g
                } else {
                    if (!a8 && bb == g && aq.triggerOnTouchLeave) {
                        ba = p
                    }
                }
            }
            return ba
        }
        function L(a9, a7) {
            var a8 = undefined;
            if (F() || S()) {
                a8 = aB(a9, a7, k)
            } else {
                if ((M() || aT()) && a8 !== false) {
                    a8 = aB(a9, a7, s)
                }
            }
            if (aC() && a8 !== false) {
                a8 = aB(a9, a7, i)
            } else {
                if (al() && a8 !== false) {
                    a8 = aB(a9, a7, b)
                } else {
                    if (ad() && a8 !== false) {
                        a8 = aB(a9, a7, x)
                    }
                }
            }
            if (a7 === p) {
                a5(a9)
            }
            if (a7 === g) {
                if (a) {
                    if (a9.touches.length == 0) {
                        a5(a9)
                    }
                } else {
                    a5(a9)
                }
            }
            return a8
        }
        function aB(ba, a7, a9) {
            var a8 = undefined;
            if (a9 == k) {
                aN.trigger("swipeStatus", [a7, aL || null, ac || 0, Y || 0, T]);
                if (aq.swipeStatus) {
                    a8 = aq.swipeStatus.call(aN, ba, a7, aL || null, ac || 0, Y || 0, T);
                    if (a8 === false) {
                        return false
                    }
                }
                if (a7 == g && aR()) {
                    aN.trigger("swipe", [aL, ac, Y, T]);
                    if (aq.swipe) {
                        a8 = aq.swipe.call(aN, ba, aL, ac, Y, T);
                        if (a8 === false) {
                            return false
                        }
                    }
                    switch (aL) {
                        case o:
                            aN.trigger("swipeLeft", [aL, ac, Y, T]);
                            if (aq.swipeLeft) {
                                a8 = aq.swipeLeft.call(aN, ba, aL, ac, Y, T)
                            }
                            break;
                        case n:
                            aN.trigger("swipeRight", [aL, ac, Y, T]);
                            if (aq.swipeRight) {
                                a8 = aq.swipeRight.call(aN, ba, aL, ac, Y, T)
                            }
                            break;
                        case d:
                            aN.trigger("swipeUp", [aL, ac, Y, T]);
                            if (aq.swipeUp) {
                                a8 = aq.swipeUp.call(aN, ba, aL, ac, Y, T)
                            }
                            break;
                        case v:
                            aN.trigger("swipeDown", [aL, ac, Y, T]);
                            if (aq.swipeDown) {
                                a8 = aq.swipeDown.call(aN, ba, aL, ac, Y, T)
                            }
                            break
                    }
                }
            }
            if (a9 == s) {
                aN.trigger("pinchStatus", [a7, aF || null, am || 0, Y || 0, T, D]);
                if (aq.pinchStatus) {
                    a8 = aq.pinchStatus.call(aN, ba, a7, aF || null, am || 0, Y || 0, T, D);
                    if (a8 === false) {
                        return false
                    }
                }
                if (a7 == g && a4()) {
                    switch (aF) {
                        case c:
                            aN.trigger("pinchIn", [aF || null, am || 0, Y || 0, T, D]);
                            if (aq.pinchIn) {
                                a8 = aq.pinchIn.call(aN, ba, aF || null, am || 0, Y || 0, T, D)
                            }
                            break;
                        case w:
                            aN.trigger("pinchOut", [aF || null, am || 0, Y || 0, T, D]);
                            if (aq.pinchOut) {
                                a8 = aq.pinchOut.call(aN, ba, aF || null, am || 0, Y || 0, T, D)
                            }
                            break
                    }
                }
            }
            if (a9 == x) {
                if (a7 === p || a7 === g) {
                    clearTimeout(aS);
                    if (V() && !E()) {
                        K = ao();
                        aS = setTimeout(e.proxy(function() {
                            K = null;
                            aN.trigger("tap", [ba.target]);
                            if (aq.tap) {
                                a8 = aq.tap.call(aN, ba, ba.target)
                            }
                        }, this), aq.doubleTapThreshold)
                    } else {
                        K = null;
                        aN.trigger("tap", [ba.target]);
                        if (aq.tap) {
                            a8 = aq.tap.call(aN, ba, ba.target)
                        }
                    }
                }
            } else {
                if (a9 == i) {
                    if (a7 === p || a7 === g) {
                        clearTimeout(aS);
                        K = null;
                        aN.trigger("doubletap", [ba.target]);
                        if (aq.doubleTap) {
                            a8 = aq.doubleTap.call(aN, ba, ba.target)
                        }
                    }
                } else {
                    if (a9 == b) {
                        if (a7 === p || a7 === g) {
                            clearTimeout(aS);
                            K = null;
                            aN.trigger("longtap", [ba.target]);
                            if (aq.longTap) {
                                a8 = aq.longTap.call(aN, ba, ba.target)
                            }
                        }
                    }
                }
            }
            return a8
        }
        function aj() {
            var a7 = true;
            if (aq.threshold !== null) {
                a7 = ac >= aq.threshold
            }
            return a7
        }
        function a6() {
            var a7 = false;
            if (aq.cancelThreshold !== null && aL !== null) {
                a7 = (aP(aL) - ac) >= aq.cancelThreshold
            }
            return a7
        }
        function ab() {
            if (aq.pinchThreshold !== null) {
                return am >= aq.pinchThreshold
            }
            return true
        }
        function aw() {
            var a7;
            if (aq.maxTimeThreshold) {
                if (Y >= aq.maxTimeThreshold) {
                    a7 = false
                } else {
                    a7 = true
                }
            } else {
                a7 = true
            }
            return a7
        }
        function ah(a7, a8) {
            if (aq.allowPageScroll === l || aT()) {
                a7.preventDefault()
            } else {
                var a9 = aq.allowPageScroll === r;
                switch (a8) {
                    case o:
                        if ((aq.swipeLeft && a9) || (!a9 && aq.allowPageScroll != A)) {
                            a7.preventDefault()
                        }
                        break;
                    case n:
                        if ((aq.swipeRight && a9) || (!a9 && aq.allowPageScroll != A)) {
                            a7.preventDefault()
                        }
                        break;
                    case d:
                        if ((aq.swipeUp && a9) || (!a9 && aq.allowPageScroll != t)) {
                            a7.preventDefault()
                        }
                        break;
                    case v:
                        if ((aq.swipeDown && a9) || (!a9 && aq.allowPageScroll != t)) {
                            a7.preventDefault()
                        }
                        break
                }
            }
        }
        function a4() {
            var a8 = aK();
            var a7 = U();
            var a9 = ab();
            return a8 && a7 && a9
        }
        function aT() {
            return !!(aq.pinchStatus || aq.pinchIn || aq.pinchOut)
        }
        function M() {
            return !!(a4() && aT())
        }
        function aR() {
            var ba = aw();
            var bc = aj();
            var a9 = aK();
            var a7 = U();
            var a8 = a6();
            var bb = !a8 && a7 && a9 && bc && ba;
            return bb
        }
        function S() {
            return !!(aq.swipe || aq.swipeStatus || aq.swipeLeft || aq.swipeRight || aq.swipeUp || aq.swipeDown)
        }
        function F() {
            return !!(aR() && S())
        }
        function aK() {
            return ((T === aq.fingers || aq.fingers === h) || !a)
        }
        function U() {
            return aM[0].end.x !== 0
        }
        function a2() {
            return !!(aq.tap)
        }
        function V() {
            return !!(aq.doubleTap)
        }
        function aQ() {
            return !!(aq.longTap)
        }
        function N() {
            if (K == null) {
                return false
            }
            var a7 = ao();
            return (V() && ((a7 - K) <= aq.doubleTapThreshold))
        }
        function E() {
            return N()
        }
        function at() {
            return ((T === 1 || !a) && (isNaN(ac) || ac === 0))
        }
        function aW() {
            return ((Y > aq.longTapThreshold) && (ac < q))
        }
        function ad() {
            return !!(at() && a2())
        }
        function aC() {
            return !!(N() && V())
        }
        function al() {
            return !!(aW() && aQ())
        }
        function C() {
            a1 = ao();
            aa = event.touches.length + 1
        }
        function O() {
            a1 = 0;
            aa = 0
        }
        function ai() {
            var a7 = false;
            if (a1) {
                var a8 = ao() - a1;
                if (a8 <= aq.fingerReleaseThreshold) {
                    a7 = true
                }
            }
            return a7
        }
        function ax() {
            return !!(aN.data(y + "_intouch") === true)
        }
        function ak(a7) {
            if (a7 === true) {
                aN.bind(au, aZ);
                aN.bind(R, I);
                if (P) {
                    aN.bind(P, H)
                }
            } else {
                aN.unbind(au, aZ, false);
                aN.unbind(R, I, false);
                if (P) {
                    aN.unbind(P, H, false)
                }
            }
            aN.data(y + "_intouch", a7 === true)
        }
        function ae(a8, a7) {
            var a9 = a7.identifier !== undefined ? a7.identifier : 0;
            aM[a8].identifier = a9;
            aM[a8].start.x = aM[a8].end.x = a7.pageX || a7.clientX;
            aM[a8].start.y = aM[a8].end.y = a7.pageY || a7.clientY;
            return aM[a8]
        }
        function aD(a7) {
            var a9 = a7.identifier !== undefined ? a7.identifier : 0;
            var a8 = Z(a9);
            a8.end.x = a7.pageX || a7.clientX;
            a8.end.y = a7.pageY || a7.clientY;
            return a8
        }
        function Z(a8) {
            for (var a7 = 0; a7 < aM.length; a7++) {
                if (aM[a7].identifier == a8) {
                    return aM[a7]
                }
            }
        }
        function af() {
            var a7 = [];
            for (var a8 = 0; a8 <= 5; a8++) {
                a7.push({
                    start: {
                        x: 0,
                        y: 0
                    },
                    end: {
                        x: 0,
                        y: 0
                    },
                    identifier: 0
                })
            }
            return a7
        }
        function aE(a7, a8) {
            a8 = Math.max(a8, aP(a7));
            J[a7].distance = a8
        }
        function aP(a7) {
            return J[a7].distance
        }
        function X() {
            var a7 = {};
            a7[o] = ar(o);
            a7[n] = ar(n);
            a7[d] = ar(d);
            a7[v] = ar(v);
            return a7
        }
        function ar(a7) {
            return {
                direction: a7,
                distance: 0
            }
        }
        function aI() {
            return aY - Q
        }
        function ap(ba, a9) {
            var a8 = Math.abs(ba.x - a9.x);
            var a7 = Math.abs(ba.y - a9.y);
            return Math.round(Math.sqrt(a8 * a8 + a7 * a7))
        }
        function a3(a7, a8) {
            var a9 = (a8 / a7) * 1;
            return a9.toFixed(2)
        }
        function an() {
            if (D < 1) {
                return w
            } else {
                return c
            }
        }
        function aO(a8, a7) {
            return Math.round(Math.sqrt(Math.pow(a7.x - a8.x, 2) + Math.pow(a7.y - a8.y, 2)))
        }
        function aA(ba, a8) {
            var a7 = ba.x - a8.x;
            var bc = a8.y - ba.y;
            var a9 = Math.atan2(bc, a7);
            var bb = Math.round(a9 * 180 / Math.PI);
            if (bb < 0) {
                bb = 360 - Math.abs(bb)
            }
            return bb
        }
        function aH(a8, a7) {
            var a9 = aA(a8, a7);
            if ((a9 <= 45) && (a9 >= 0)) {
                return o
            } else {
                if ((a9 <= 360) && (a9 >= 315)) {
                    return o
                } else {
                    if ((a9 >= 135) && (a9 <= 225)) {
                        return n
                    } else {
                        if ((a9 > 45) && (a9 < 135)) {
                            return v
                        } else {
                            return d
                        }
                    }
                }
            }
        }
        function ao() {
            var a7 = new Date();
            return a7.getTime()
        }
        function aU(a7) {
            a7 = e(a7);
            var a9 = a7.offset();
            var a8 = {
                left: a9.left,
                right: a9.left + a7.outerWidth(),
                top: a9.top,
                bottom: a9.top + a7.outerHeight()
            };
            return a8
        }
        function B(a7, a8) {
            return (a7.x > a8.left && a7.x < a8.right && a7.y > a8.top && a7.y < a8.bottom)
        }
    }
})(jQuery);
!
    function(a) {
        a.fn.slide = function(b) {
            return a.fn.slide.defaults = {
                type: "slide",
                effect: "fade",
                autoPlay: !1,
                delayTime: 500,
                interTime: 2500,
                triggerTime: 150,
                defaultIndex: 0,
                titCell: ".hd li",
                mainCell: ".bd",
                targetCell: null,
                trigger: "mouseover",
                scroll: 1,
                vis: 1,
                titOnClassName: "on",
                autoPage: !1,
                prevCell: ".prev",
                nextCell: ".next",
                pageStateCell: ".pageState",
                opp: !1,
                pnLoop: !0,
                easing: "swing",
                startFun: null,
                endFun: null,
                switchLoad: null,
                playStateCell: ".playState",
                mouseOverStop: !0,
                defaultPlay: !0,
                returnDefault: !1
            }, this.each(function() {
                var c = a.extend({}, a.fn.slide.defaults, b),
                    d = a(this),
                    e = c.effect,
                    f = a(c.prevCell, d),
                    g = a(c.nextCell, d),
                    h = a(c.pageStateCell, d),
                    i = a(c.playStateCell, d),
                    j = a(c.titCell, d),
                    k = j.size(),
                    l = a(c.mainCell, d),
                    m = l.children().size(),
                    n = c.switchLoad,
                    o = a(c.targetCell, d),
                    p = parseInt(c.defaultIndex),
                    q = parseInt(c.delayTime),
                    r = parseInt(c.interTime);
                parseInt(c.triggerTime);
                var Q, t = parseInt(c.scroll),
                    u = parseInt(c.vis),
                    v = "false" == c.autoPlay || 0 == c.autoPlay ? !1 : !0,
                    w = "false" == c.opp || 0 == c.opp ? !1 : !0,
                    x = "false" == c.autoPage || 0 == c.autoPage ? !1 : !0,
                    y = "false" == c.pnLoop || 0 == c.pnLoop ? !1 : !0,
                    z = "false" == c.mouseOverStop || 0 == c.mouseOverStop ? !1 : !0,
                    A = "false" == c.defaultPlay || 0 == c.defaultPlay ? !1 : !0,
                    B = "false" == c.returnDefault || 0 == c.returnDefault ? !1 : !0,
                    C = 0,
                    D = 0,
                    E = 0,
                    F = 0,
                    G = c.easing,
                    H = null,
                    I = null,
                    J = null,
                    K = c.titOnClassName,
                    L = j.index(d.find("." + K)),
                    M = p = -1 == L ? p : L,
                    N = p,
                    O = p,
                    P = m >= u ? 0 != m % t ? m % t : t : 0,
                    R = "leftMarquee" == e || "topMarquee" == e ? !0 : !1,
                    S = function() {
                        a.isFunction(c.startFun) && c.startFun(p, k, d, a(c.titCell, d), l, o, f, g)
                    },
                    T = function() {
                        a.isFunction(c.endFun) && c.endFun(p, k, d, a(c.titCell, d), l, o, f, g)
                    },
                    U = function() {
                        j.removeClass(K), A && j.eq(N).addClass(K)
                    };
                if ("menu" == c.type) return A && j.removeClass(K).eq(p).addClass(K), j.hover(function() {
                    Q = a(this).find(c.targetCell);
                    var b = j.index(a(this));
                    I = setTimeout(function() {
                        switch (p = b, j.removeClass(K).eq(p).addClass(K), S(), e) {
                            case "fade":
                                Q.stop(!0, !0).animate({
                                    opacity: "show"
                                }, q, G, T);
                                break;
                            case "slideDown":
                                Q.stop(!0, !0).animate({
                                    height: "show"
                                }, q, G, T)
                        }
                    }, c.triggerTime)
                }, function() {
                    switch (clearTimeout(I), e) {
                        case "fade":
                            Q.animate({
                                opacity: "hide"
                            }, q, G);
                            break;
                        case "slideDown":
                            Q.animate({
                                height: "hide"
                            }, q, G)
                    }
                }), B && d.hover(function() {
                    clearTimeout(J)
                }, function() {
                    J = setTimeout(U, q)
                }), void 0;
                if (0 == k && (k = m), R && (k = 2), x) {
                    if (m >= u) if ("leftLoop" == e || "topLoop" == e) k = 0 != m % t ? (0 ^ m / t) + 1 : m / t;
                    else {
                        var V = m - u;
                        k = 1 + parseInt(0 != V % t ? V / t + 1 : V / t), 0 >= k && (k = 1)
                    } else k = 1;
                    j.html("");
                    var W = "";
                    if (1 == c.autoPage || "true" == c.autoPage) for (var X = 0; k > X; X++) W += "<li>" + (X + 1) + "</li>";
                    else for (var X = 0; k > X; X++) W += c.autoPage.replace("$", X + 1);
                    j.html(W);
                    var j = j.children()
                }
                if (m >= u) {
                    l.children().each(function() {
                        a(this).width() > E && (E = a(this).width(), D = a(this).outerWidth(!0)), a(this).height() > F && (F = a(this).height(), C = a(this).outerHeight(!0))
                    });
                    var Y = l.children(),
                        Z = function() {
                            for (var a = 0; u > a; a++) Y.eq(a).clone().addClass("clone").appendTo(l);
                            for (var a = 0; P > a; a++) Y.eq(m - a - 1).clone().addClass("clone").prependTo(l)
                        };
                    switch (e) {
                        case "fold":
                            l.css({
                                position: "relative",
                                width: D,
                                height: C
                            }).children().css({
                                position: "absolute",
                                width: E,
                                left: 0,
                                top: 0,
                                display: "none"
                            });
                            break;
                        case "top":
                            l.wrap('<div class="tempWrap" style="overflow:hidden; position:relative; height:' + u * C + 'px"></div>').css({
                                top: -(p * t) * C,
                                position: "relative",
                                padding: "0",
                                margin: "0"
                            }).children().css({
                                height: F
                            });
                            break;
                        case "left":
                            l.wrap('<div class="tempWrap" style="overflow:hidden; position:relative; width:' + u * D + 'px"></div>').css({
                                width: m * D,
                                left: -(p * t) * D,
                                position: "relative",
                                overflow: "hidden",
                                padding: "0",
                                margin: "0"
                            }).children().css({
                                "float": "left",
                                width: E
                            });
                            break;
                        case "leftLoop":
                        case "leftMarquee":
                            Z(), l.wrap('<div class="tempWrap" style="overflow:hidden; position:relative; width:' + u * D + 'px"></div>').css({
                                width: (m + u + P) * D,
                                position: "relative",
                                overflow: "hidden",
                                padding: "0",
                                margin: "0",
                                left: -(P + p * t) * D
                            }).children().css({
                                "float": "left",
                                width: E
                            });
                            break;
                        case "topLoop":
                        case "topMarquee":
                            Z(), l.wrap('<div class="tempWrap" style="overflow:hidden; position:relative; height:' + u * C + 'px"></div>').css({
                                height: (m + u + P) * C,
                                position: "relative",
                                padding: "0",
                                margin: "0",
                                top: -(P + p * t) * C
                            }).children().css({
                                height: F
                            })
                    }
                }
                var $ = function(a) {
                        var b = a * t;
                        return a == k ? b = m : -1 == a && 0 != m % t && (b = -m % t), b
                    },
                    _ = function(b) {
                        var c = function(c) {
                            for (var d = c; u + c > d; d++) b.eq(d).find("img[" + n + "]").each(function() {
                                var b = a(this);
                                if (b.attr("src", b.attr(n)).removeAttr(n), l.find(".clone")[0]) for (var c = l.children(), d = 0; d < c.size(); d++) c.eq(d).find("img[" + n + "]").each(function() {
                                    a(this).attr(n) == b.attr("src") && a(this).attr("src", a(this).attr(n)).removeAttr(n)
                                })
                            })
                        };
                        switch (e) {
                            case "fade":
                            case "fold":
                            case "top":
                            case "left":
                            case "slideDown":
                                c(p * t);
                                break;
                            case "leftLoop":
                            case "topLoop":
                                c(P + $(O));
                                break;
                            case "leftMarquee":
                            case "topMarquee":
                                var d = "leftMarquee" == e ? l.css("left").replace("px", "") : l.css("top").replace("px", ""),
                                    f = "leftMarquee" == e ? D : C,
                                    g = P;
                                if (0 != d % f) {
                                    var h = Math.abs(0 ^ d / f);
                                    g = 1 == p ? P + h : P + h - 1
                                }
                                c(g)
                        }
                    },
                    ab = function(a) {
                        if (!A || M != p || a || R) {
                            if (R ? p >= 1 ? p = 1 : 0 >= p && (p = 0) : (O = p, p >= k ? p = 0 : 0 > p && (p = k - 1)), S(), null != n && _(l.children()), o[0] && (Q = o.eq(p), null != n && _(o), "slideDown" == e ? (o.not(Q).stop(!0, !0).slideUp(q), Q.slideDown(q, G, function() {
                                    l[0] || T()
                                })) : (o.not(Q).stop(!0, !0).hide(), Q.animate({
                                    opacity: "show"
                                }, q, function() {
                                    l[0] || T()
                                }))), m >= u) switch (e) {
                                case "fade":
                                    l.children().stop(!0, !0).eq(p).animate({
                                        opacity: "show"
                                    }, q, G, function() {
                                        T()
                                    }).siblings().hide();
                                    break;
                                case "fold":
                                    l.children().stop(!0, !0).eq(p).animate({
                                        opacity: "show"
                                    }, q, G, function() {
                                        T()
                                    }).siblings().animate({
                                        opacity: "hide"
                                    }, q, G);
                                    break;
                                case "top":
                                    l.stop(!0, !1).animate({
                                        top: -p * t * C
                                    }, q, G, function() {
                                        T()
                                    });
                                    break;
                                case "left":
                                    l.stop(!0, !1).animate({
                                        left: -p * t * D
                                    }, q, G, function() {
                                        T()
                                    });
                                    break;
                                case "leftLoop":
                                    var b = O;
                                    l.stop(!0, !0).animate({
                                        left: -($(O) + P) * D
                                    }, q, G, function() {
                                        -1 >= b ? l.css("left", -(P + (k - 1) * t) * D) : b >= k && l.css("left", -P * D), T()
                                    });
                                    break;
                                case "topLoop":
                                    var b = O;
                                    l.stop(!0, !0).animate({
                                        top: -($(O) + P) * C
                                    }, q, G, function() {
                                        -1 >= b ? l.css("top", -(P + (k - 1) * t) * C) : b >= k && l.css("top", -P * C), T()
                                    });
                                    break;
                                case "leftMarquee":
                                    var c = l.css("left").replace("px", "");
                                    0 == p ? l.animate({
                                        left: ++c
                                    }, 0, function() {
                                        l.css("left").replace("px", "") >= 0 && l.css("left", -m * D)
                                    }) : l.animate({
                                        left: --c
                                    }, 0, function() {
                                        l.css("left").replace("px", "") <= -(m + P) * D && l.css("left", -P * D)
                                    });
                                    break;
                                case "topMarquee":
                                    var d = l.css("top").replace("px", "");
                                    0 == p ? l.animate({
                                        top: ++d
                                    }, 0, function() {
                                        l.css("top").replace("px", "") >= 0 && l.css("top", -m * C)
                                    }) : l.animate({
                                        top: --d
                                    }, 0, function() {
                                        l.css("top").replace("px", "") <= -(m + P) * C && l.css("top", -P * C)
                                    })
                            }
                            j.removeClass(K).eq(p).addClass(K), M = p, y || (g.removeClass("nextStop"), f.removeClass("prevStop"), 0 == p && f.addClass("prevStop"), p == k - 1 && g.addClass("nextStop")), h.html("<span>" + (p + 1) + "</span>/" + k)
                        }
                    };
                A && ab(!0), B && d.hover(function() {
                    clearTimeout(J)
                }, function() {
                    J = setTimeout(function() {
                        p = N, A ? ab() : "slideDown" == e ? Q.slideUp(q, U) : Q.animate({
                            opacity: "hide"
                        }, q, U), M = p
                    }, 300)
                });
                var bb = function(a) {
                        H = setInterval(function() {
                            w ? p-- : p++, ab()
                        }, a ? a : r)
                    },
                    cb = function(a) {
                        H = setInterval(ab, a ? a : r)
                    },
                    db = function() {
                        z || (clearInterval(H), bb())
                    },
                    eb = function() {
                        (y || p != k - 1) && (p++, ab(), R || db())
                    },
                    fb = function() {
                        (y || 0 != p) && (p--, ab(), R || db())
                    },
                    gb = function() {
                        clearInterval(H), R ? cb() : bb(), i.removeClass("pauseState")
                    },
                    hb = function() {
                        clearInterval(H), i.addClass("pauseState")
                    };
                if (v ? R ? (w ? p-- : p++, cb(), z && l.hover(hb, gb)) : (bb(), z && d.hover(hb, gb)) : (R && (w ? p-- : p++), i.addClass("pauseState")), i.click(function() {
                        i.hasClass("pauseState") ? gb() : hb()
                    }), "mouseover" == c.trigger ? j.hover(function() {
                        var a = j.index(this);
                        I = setTimeout(function() {
                            p = a, ab(), db()
                        }, c.triggerTime)
                    }, function() {
                        clearTimeout(I)
                    }) : j.click(function() {
                        p = j.index(this), ab(), db()
                    }), R) {
                    if (g.mousedown(eb), f.mousedown(fb), y) {
                        var ib, jb = function() {
                                ib = setTimeout(function() {
                                    clearInterval(H), cb(0 ^ r / 10)
                                }, 150)
                            },
                            kb = function() {
                                clearTimeout(ib), clearInterval(H), cb()
                            };
                        g.mousedown(jb), g.mouseup(kb), f.mousedown(jb), f.mouseup(kb)
                    }
                    "mouseover" == c.trigger && (g.hover(eb, function() {}), f.hover(fb, function() {}))
                } else g.click(eb), f.click(fb)
            })
        }
    }(jQuery), jQuery.easing.jswing = jQuery.easing.swing, jQuery.extend(jQuery.easing, {
    def: "easeOutQuad",
    swing: function(a, b, c, d, e) {
        return jQuery.easing[jQuery.easing.def](a, b, c, d, e)
    },
    easeInQuad: function(a, b, c, d, e) {
        return d * (b /= e) * b + c
    },
    easeOutQuad: function(a, b, c, d, e) {
        return -d * (b /= e) * (b - 2) + c
    },
    easeInOutQuad: function(a, b, c, d, e) {
        return (b /= e / 2) < 1 ? d / 2 * b * b + c : -d / 2 * (--b * (b - 2) - 1) + c
    },
    easeInCubic: function(a, b, c, d, e) {
        return d * (b /= e) * b * b + c
    },
    easeOutCubic: function(a, b, c, d, e) {
        return d * ((b = b / e - 1) * b * b + 1) + c
    },
    easeInOutCubic: function(a, b, c, d, e) {
        return (b /= e / 2) < 1 ? d / 2 * b * b * b + c : d / 2 * ((b -= 2) * b * b + 2) + c
    },
    easeInQuart: function(a, b, c, d, e) {
        return d * (b /= e) * b * b * b + c
    },
    easeOutQuart: function(a, b, c, d, e) {
        return -d * ((b = b / e - 1) * b * b * b - 1) + c
    },
    easeInOutQuart: function(a, b, c, d, e) {
        return (b /= e / 2) < 1 ? d / 2 * b * b * b * b + c : -d / 2 * ((b -= 2) * b * b * b - 2) + c
    },
    easeInQuint: function(a, b, c, d, e) {
        return d * (b /= e) * b * b * b * b + c
    },
    easeOutQuint: function(a, b, c, d, e) {
        return d * ((b = b / e - 1) * b * b * b * b + 1) + c
    },
    easeInOutQuint: function(a, b, c, d, e) {
        return (b /= e / 2) < 1 ? d / 2 * b * b * b * b * b + c : d / 2 * ((b -= 2) * b * b * b * b + 2) + c
    },
    easeInSine: function(a, b, c, d, e) {
        return -d * Math.cos(b / e * (Math.PI / 2)) + d + c
    },
    easeOutSine: function(a, b, c, d, e) {
        return d * Math.sin(b / e * (Math.PI / 2)) + c
    },
    easeInOutSine: function(a, b, c, d, e) {
        return -d / 2 * (Math.cos(Math.PI * b / e) - 1) + c
    },
    easeInExpo: function(a, b, c, d, e) {
        return 0 == b ? c : d * Math.pow(2, 10 * (b / e - 1)) + c
    },
    easeOutExpo: function(a, b, c, d, e) {
        return b == e ? c + d : d * (-Math.pow(2, -10 * b / e) + 1) + c
    },
    easeInOutExpo: function(a, b, c, d, e) {
        return 0 == b ? c : b == e ? c + d : (b /= e / 2) < 1 ? d / 2 * Math.pow(2, 10 * (b - 1)) + c : d / 2 * (-Math.pow(2, -10 * --b) + 2) + c
    },
    easeInCirc: function(a, b, c, d, e) {
        return -d * (Math.sqrt(1 - (b /= e) * b) - 1) + c
    },
    easeOutCirc: function(a, b, c, d, e) {
        return d * Math.sqrt(1 - (b = b / e - 1) * b) + c
    },
    easeInOutCirc: function(a, b, c, d, e) {
        return (b /= e / 2) < 1 ? -d / 2 * (Math.sqrt(1 - b * b) - 1) + c : d / 2 * (Math.sqrt(1 - (b -= 2) * b) + 1) + c
    },
    easeInElastic: function(a, b, c, d, e) {
        var f = 1.70158,
            g = 0,
            h = d;
        if (0 == b) return c;
        if (1 == (b /= e)) return c + d;
        if (g || (g = .3 * e), h < Math.abs(d)) {
            h = d;
            var f = g / 4
        } else var f = g / (2 * Math.PI) * Math.asin(d / h);
        return -(h * Math.pow(2, 10 * (b -= 1)) * Math.sin((b * e - f) * 2 * Math.PI / g)) + c
    },
    easeOutElastic: function(a, b, c, d, e) {
        var f = 1.70158,
            g = 0,
            h = d;
        if (0 == b) return c;
        if (1 == (b /= e)) return c + d;
        if (g || (g = .3 * e), h < Math.abs(d)) {
            h = d;
            var f = g / 4
        } else var f = g / (2 * Math.PI) * Math.asin(d / h);
        return h * Math.pow(2, -10 * b) * Math.sin((b * e - f) * 2 * Math.PI / g) + d + c
    },
    easeInOutElastic: function(a, b, c, d, e) {
        var f = 1.70158,
            g = 0,
            h = d;
        if (0 == b) return c;
        if (2 == (b /= e / 2)) return c + d;
        if (g || (g = e * .3 * 1.5), h < Math.abs(d)) {
            h = d;
            var f = g / 4
        } else var f = g / (2 * Math.PI) * Math.asin(d / h);
        return 1 > b ? -.5 * h * Math.pow(2, 10 * (b -= 1)) * Math.sin((b * e - f) * 2 * Math.PI / g) + c : .5 * h * Math.pow(2, -10 * (b -= 1)) * Math.sin((b * e - f) * 2 * Math.PI / g) + d + c
    },
    easeInBack: function(a, b, c, d, e, f) {
        return void 0 == f && (f = 1.70158), d * (b /= e) * b * ((f + 1) * b - f) + c
    },
    easeOutBack: function(a, b, c, d, e, f) {
        return void 0 == f && (f = 1.70158), d * ((b = b / e - 1) * b * ((f + 1) * b + f) + 1) + c
    },
    easeInOutBack: function(a, b, c, d, e, f) {
        return void 0 == f && (f = 1.70158), (b /= e / 2) < 1 ? d / 2 * b * b * (((f *= 1.525) + 1) * b - f) + c : d / 2 * ((b -= 2) * b * (((f *= 1.525) + 1) * b + f) + 2) + c
    },
    easeInBounce: function(a, b, c, d, e) {
        return d - jQuery.easing.easeOutBounce(a, e - b, 0, d, e) + c
    },
    easeOutBounce: function(a, b, c, d, e) {
        return (b /= e) < 1 / 2.75 ? d * 7.5625 * b * b + c : 2 / 2.75 > b ? d * (7.5625 * (b -= 1.5 / 2.75) * b + .75) + c : 2.5 / 2.75 > b ? d * (7.5625 * (b -= 2.25 / 2.75) * b + .9375) + c : d * (7.5625 * (b -= 2.625 / 2.75) * b + .984375) + c
    },
    easeInOutBounce: function(a, b, c, d, e) {
        return e / 2 > b ? .5 * jQuery.easing.easeInBounce(a, 2 * b, 0, d, e) + c : .5 * jQuery.easing.easeOutBounce(a, 2 * b - e, 0, d, e) + .5 * d + c
    }
});
var Swiper = function(a, b) {
    "use strict";

    function c(a, b) {
        return document.querySelectorAll ? (b || document).querySelectorAll(a) : jQuery(a, b)
    }
    function d(a) {
        return "[object Array]" === Object.prototype.toString.apply(a) ? !0 : !1
    }
    function e() {
        var a = G - J;
        return b.freeMode && (a = G - J), b.slidesPerView > D.slides.length && !b.centeredSlides && (a = 0), 0 > a && (a = 0), a
    }
    function f() {
        function a(a) {
            var c, d, e = function() {
                "undefined" != typeof D && null !== D && (void 0 !== D.imagesLoaded && D.imagesLoaded++, D.imagesLoaded === D.imagesToLoad.length && (D.reInit(), b.onImagesReady && D.fireCallback(b.onImagesReady, D)))
            };
            a.complete ? e() : (d = a.currentSrc || a.getAttribute("src"), d ? (c = new Image, c.onload = e, c.onerror = e, c.src = d) : e())
        }
        var d = D.h.addEventListener,
            e = "wrapper" === b.eventTarget ? D.wrapper : D.container;
        if (D.browser.ie10 || D.browser.ie11 ? (d(e, D.touchEvents.touchStart, p), d(document, D.touchEvents.touchMove, q), d(document, D.touchEvents.touchEnd, r)) : (D.support.touch && (d(e, "touchstart", p), d(e, "touchmove", q), d(e, "touchend", r)), b.simulateTouch && (d(e, "mousedown", p), d(document, "mousemove", q), d(document, "mouseup", r))), b.autoResize && d(window, "resize", D.resizeFix), g(), D._wheelEvent = !1, b.mousewheelControl) {
            if (void 0 !== document.onmousewheel && (D._wheelEvent = "mousewheel"), !D._wheelEvent) try {
                new WheelEvent("wheel"), D._wheelEvent = "wheel"
            } catch (f) {}
            D._wheelEvent || (D._wheelEvent = "DOMMouseScroll"), D._wheelEvent && d(D.container, D._wheelEvent, j)
        }
        if (b.keyboardControl && d(document, "keydown", i), b.updateOnImagesReady) {
            D.imagesToLoad = c("img", D.container);
            for (var h = 0; h < D.imagesToLoad.length; h++) a(D.imagesToLoad[h])
        }
    }
    function g() {
        var a, d = D.h.addEventListener;
        if (b.preventLinks) {
            var e = c("a", D.container);
            for (a = 0; a < e.length; a++) d(e[a], "click", n)
        }
        if (b.releaseFormElements) {
            var f = c("input, textarea, select", D.container);
            for (a = 0; a < f.length; a++) d(f[a], D.touchEvents.touchStart, o, !0), D.support.touch && b.simulateTouch && d(f[a], "mousedown", o, !0)
        }
        if (b.onSlideClick) for (a = 0; a < D.slides.length; a++) d(D.slides[a], "click", k);
        if (b.onSlideTouch) for (a = 0; a < D.slides.length; a++) d(D.slides[a], D.touchEvents.touchStart, l)
    }
    function h() {
        var a, d = D.h.removeEventListener;
        if (b.onSlideClick) for (a = 0; a < D.slides.length; a++) d(D.slides[a], "click", k);
        if (b.onSlideTouch) for (a = 0; a < D.slides.length; a++) d(D.slides[a], D.touchEvents.touchStart, l);
        if (b.releaseFormElements) {
            var e = c("input, textarea, select", D.container);
            for (a = 0; a < e.length; a++) d(e[a], D.touchEvents.touchStart, o, !0), D.support.touch && b.simulateTouch && d(e[a], "mousedown", o, !0)
        }
        if (b.preventLinks) {
            var f = c("a", D.container);
            for (a = 0; a < f.length; a++) d(f[a], "click", n)
        }
    }
    function i(a) {
        var b = a.keyCode || a.charCode;
        if (!(a.shiftKey || a.altKey || a.ctrlKey || a.metaKey)) {
            if (37 === b || 39 === b || 38 === b || 40 === b) {
                for (var c = !1, d = D.h.getOffset(D.container), e = D.h.windowScroll().left, f = D.h.windowScroll().top, g = D.h.windowWidth(), h = D.h.windowHeight(), i = [
                    [d.left, d.top],
                    [d.left + D.width, d.top],
                    [d.left, d.top + D.height],
                    [d.left + D.width, d.top + D.height]
                ], j = 0; j < i.length; j++) {
                    var k = i[j];
                    k[0] >= e && k[0] <= e + g && k[1] >= f && k[1] <= f + h && (c = !0)
                }
                if (!c) return
            }
            N ? ((37 === b || 39 === b) && (a.preventDefault ? a.preventDefault() : a.returnValue = !1), 39 === b && D.swipeNext(), 37 === b && D.swipePrev()) : ((38 === b || 40 === b) && (a.preventDefault ? a.preventDefault() : a.returnValue = !1), 40 === b && D.swipeNext(), 38 === b && D.swipePrev())
        }
    }
    function j(a) {
        var c = D._wheelEvent,
            d = 0;
        if (a.detail) d = -a.detail;
        else if ("mousewheel" === c) if (b.mousewheelControlForceToAxis) if (N) {
            if (!(Math.abs(a.wheelDeltaX) > Math.abs(a.wheelDeltaY))) return;
            d = a.wheelDeltaX
        } else {
            if (!(Math.abs(a.wheelDeltaY) > Math.abs(a.wheelDeltaX))) return;
            d = a.wheelDeltaY
        } else d = a.wheelDelta;
        else if ("DOMMouseScroll" === c) d = -a.detail;
        else if ("wheel" === c) if (b.mousewheelControlForceToAxis) if (N) {
            if (!(Math.abs(a.deltaX) > Math.abs(a.deltaY))) return;
            d = -a.deltaX
        } else {
            if (!(Math.abs(a.deltaY) > Math.abs(a.deltaX))) return;
            d = -a.deltaY
        } else d = Math.abs(a.deltaX) > Math.abs(a.deltaY) ? -a.deltaX : -a.deltaY;
        if (b.freeMode) {
            var f = D.getWrapperTranslate() + d;
            if (f > 0 && (f = 0), f < -e() && (f = -e()), D.setWrapperTransition(0), D.setWrapperTranslate(f), D.updateActiveSlide(f), 0 === f || f === -e()) return
        } else(new Date).getTime() - V > 60 && (0 > d ? D.swipeNext() : D.swipePrev()), V = (new Date).getTime();
        return b.autoplay && D.stopAutoplay(!0), a.preventDefault ? a.preventDefault() : a.returnValue = !1, !1
    }
    function k(a) {
        D.allowSlideClick && (m(a), D.fireCallback(b.onSlideClick, D, a))
    }
    function l(a) {
        m(a), D.fireCallback(b.onSlideTouch, D, a)
    }
    function m(a) {
        if (a.currentTarget) D.clickedSlide = a.currentTarget;
        else {
            var c = a.srcElement;
            do {
                if (c.className.indexOf(b.slideClass) > -1) break;
                c = c.parentNode
            } while (c);
            D.clickedSlide = c
        }
        D.clickedSlideIndex = D.slides.indexOf(D.clickedSlide), D.clickedSlideLoopIndex = D.clickedSlideIndex - (D.loopedSlides || 0)
    }
    function n(a) {
        return D.allowLinks ? void 0 : (a.preventDefault ? a.preventDefault() : a.returnValue = !1, b.preventLinksPropagation && "stopPropagation" in a && a.stopPropagation(), !1)
    }
    function o(a) {
        return a.stopPropagation ? a.stopPropagation() : a.returnValue = !1, !1
    }
    function p(a) {
        if (b.preventLinks && (D.allowLinks = !0), D.isTouched || b.onlyExternal) return !1;
        var c = a.target || a.srcElement;
        document.activeElement && document.activeElement !== document.body && document.activeElement !== c && document.activeElement.blur();
        var d = "input select textarea".split(" ");
        if (b.noSwiping && c && t(c)) return !1;
        if (_ = !1, D.isTouched = !0, $ = "touchstart" === a.type, !$ && "which" in a && 3 === a.which) return D.isTouched = !1, !1;
        if (!$ || 1 === a.targetTouches.length) {
            D.callPlugins("onTouchStartBegin"), !$ && !D.isAndroid && d.indexOf(c.tagName.toLowerCase()) < 0 && (a.preventDefault ? a.preventDefault() : a.returnValue = !1);
            var e = $ ? a.targetTouches[0].pageX : a.pageX || a.clientX,
                f = $ ? a.targetTouches[0].pageY : a.pageY || a.clientY;
            D.touches.startX = D.touches.currentX = e, D.touches.startY = D.touches.currentY = f, D.touches.start = D.touches.current = N ? e : f, D.setWrapperTransition(0), D.positions.start = D.positions.current = D.getWrapperTranslate(), D.setWrapperTranslate(D.positions.start), D.times.start = (new Date).getTime(), I = void 0, b.moveStartThreshold > 0 && (X = !1), b.onTouchStart && D.fireCallback(b.onTouchStart, D, a), D.callPlugins("onTouchStartEnd")
        }
    }
    function q(a) {
        if (D.isTouched && !b.onlyExternal && (!$ || "mousemove" !== a.type)) {
            var c = $ ? a.targetTouches[0].pageX : a.pageX || a.clientX,
                d = $ ? a.targetTouches[0].pageY : a.pageY || a.clientY;
            if ("undefined" == typeof I && N && (I = !! (I || Math.abs(d - D.touches.startY) > Math.abs(c - D.touches.startX))), "undefined" != typeof I || N || (I = !! (I || Math.abs(d - D.touches.startY) < Math.abs(c - D.touches.startX))), I) return void(D.isTouched = !1);
            if (N) {
                if (!b.swipeToNext && c < D.touches.startX || !b.swipeToPrev && c > D.touches.startX) return
            } else if (!b.swipeToNext && d < D.touches.startY || !b.swipeToPrev && d > D.touches.startY) return;
            if (a.assignedToSwiper) return void(D.isTouched = !1);
            if (a.assignedToSwiper = !0, b.preventLinks && (D.allowLinks = !1), b.onSlideClick && (D.allowSlideClick = !1), b.autoplay && D.stopAutoplay(!0), !$ || 1 === a.touches.length) {
                if (D.isMoved || (D.callPlugins("onTouchMoveStart"), b.loop && (D.fixLoop(), D.positions.start = D.getWrapperTranslate()), b.onTouchMoveStart && D.fireCallback(b.onTouchMoveStart, D)), D.isMoved = !0, a.preventDefault ? a.preventDefault() : a.returnValue = !1, D.touches.current = N ? c : d, D.positions.current = (D.touches.current - D.touches.start) * b.touchRatio + D.positions.start, D.positions.current > 0 && b.onResistanceBefore && D.fireCallback(b.onResistanceBefore, D, D.positions.current), D.positions.current < -e() && b.onResistanceAfter && D.fireCallback(b.onResistanceAfter, D, Math.abs(D.positions.current + e())), b.resistance && "100%" !== b.resistance) {
                    var f;
                    if (D.positions.current > 0 && (f = 1 - D.positions.current / J / 2, D.positions.current = .5 > f ? J / 2 : D.positions.current * f), D.positions.current < -e()) {
                        var g = (D.touches.current - D.touches.start) * b.touchRatio + (e() + D.positions.start);
                        f = (J + g) / J;
                        var h = D.positions.current - g * (1 - f) / 2,
                            i = -e() - J / 2;
                        D.positions.current = i > h || 0 >= f ? i : h
                    }
                }
                if (b.resistance && "100%" === b.resistance && (D.positions.current > 0 && (!b.freeMode || b.freeModeFluid) && (D.positions.current = 0), D.positions.current < -e() && (!b.freeMode || b.freeModeFluid) && (D.positions.current = -e())), !b.followFinger) return;
                if (b.moveStartThreshold) if (Math.abs(D.touches.current - D.touches.start) > b.moveStartThreshold || X) {
                    if (!X) return X = !0, void(D.touches.start = D.touches.current);
                    D.setWrapperTranslate(D.positions.current)
                } else D.positions.current = D.positions.start;
                else D.setWrapperTranslate(D.positions.current);
                return (b.freeMode || b.watchActiveIndex) && D.updateActiveSlide(D.positions.current), b.grabCursor && (D.container.style.cursor = "move", D.container.style.cursor = "grabbing", D.container.style.cursor = "-moz-grabbin", D.container.style.cursor = "-webkit-grabbing"), Y || (Y = D.touches.current), Z || (Z = (new Date).getTime()), D.velocity = (D.touches.current - Y) / ((new Date).getTime() - Z) / 2, Math.abs(D.touches.current - Y) < 2 && (D.velocity = 0), Y = D.touches.current, Z = (new Date).getTime(), D.callPlugins("onTouchMoveEnd"), b.onTouchMove && D.fireCallback(b.onTouchMove, D, a), !1
            }
        }
    }
    function r(a) {
        if (I && D.swipeReset(), !b.onlyExternal && D.isTouched) {
            D.isTouched = !1, b.grabCursor && (D.container.style.cursor = "move", D.container.style.cursor = "grab", D.container.style.cursor = "-moz-grab", D.container.style.cursor = "-webkit-grab"), D.positions.current || 0 === D.positions.current || (D.positions.current = D.positions.start), b.followFinger && D.setWrapperTranslate(D.positions.current), D.times.end = (new Date).getTime(), D.touches.diff = D.touches.current - D.touches.start, D.touches.abs = Math.abs(D.touches.diff), D.positions.diff = D.positions.current - D.positions.start, D.positions.abs = Math.abs(D.positions.diff);
            var c = D.positions.diff,
                d = D.positions.abs,
                f = D.times.end - D.times.start;
            5 > d && 300 > f && D.allowLinks === !1 && (b.freeMode || 0 === d || D.swipeReset(), b.preventLinks && (D.allowLinks = !0), b.onSlideClick && (D.allowSlideClick = !0)), setTimeout(function() {
                "undefined" != typeof D && null !== D && (b.preventLinks && (D.allowLinks = !0), b.onSlideClick && (D.allowSlideClick = !0))
            }, 100);
            var g = e();
            if (!D.isMoved && b.freeMode) return D.isMoved = !1, b.onTouchEnd && D.fireCallback(b.onTouchEnd, D, a), void D.callPlugins("onTouchEnd");
            if (!D.isMoved || D.positions.current > 0 || D.positions.current < -g) return D.swipeReset(), b.onTouchEnd && D.fireCallback(b.onTouchEnd, D, a), void D.callPlugins("onTouchEnd");
            if (D.isMoved = !1, b.freeMode) {
                if (b.freeModeFluid) {
                    var h, i = 1e3 * b.momentumRatio,
                        j = D.velocity * i,
                        k = D.positions.current + j,
                        l = !1,
                        m = 20 * Math.abs(D.velocity) * b.momentumBounceRatio; - g > k && (b.momentumBounce && D.support.transitions ? (-m > k + g && (k = -g - m), h = -g, l = !0, _ = !0) : k = -g), k > 0 && (b.momentumBounce && D.support.transitions ? (k > m && (k = m), h = 0, l = !0, _ = !0) : k = 0), 0 !== D.velocity && (i = Math.abs((k - D.positions.current) / D.velocity)), D.setWrapperTranslate(k), D.setWrapperTransition(i), b.momentumBounce && l && D.wrapperTransitionEnd(function() {
                        _ && (b.onMomentumBounce && D.fireCallback(b.onMomentumBounce, D), D.callPlugins("onMomentumBounce"), D.setWrapperTranslate(h), D.setWrapperTransition(300))
                    }), D.updateActiveSlide(k)
                }
                return (!b.freeModeFluid || f >= 300) && D.updateActiveSlide(D.positions.current), b.onTouchEnd && D.fireCallback(b.onTouchEnd, D, a), void D.callPlugins("onTouchEnd")
            }
            H = 0 > c ? "toNext" : "toPrev", "toNext" === H && 300 >= f && (30 > d || !b.shortSwipes ? D.swipeReset() : D.swipeNext(!0, !0)), "toPrev" === H && 300 >= f && (30 > d || !b.shortSwipes ? D.swipeReset() : D.swipePrev(!0, !0));
            var n = 0;
            if ("auto" === b.slidesPerView) {
                for (var o, p = Math.abs(D.getWrapperTranslate()), q = 0, r = 0; r < D.slides.length; r++) if (o = N ? D.slides[r].getWidth(!0, b.roundLengths) : D.slides[r].getHeight(!0, b.roundLengths), q += o, q > p) {
                    n = o;
                    break
                }
                n > J && (n = J)
            } else n = F * b.slidesPerView;
            "toNext" === H && f > 300 && (d >= n * b.longSwipesRatio ? D.swipeNext(!0, !0) : D.swipeReset()), "toPrev" === H && f > 300 && (d >= n * b.longSwipesRatio ? D.swipePrev(!0, !0) : D.swipeReset()), b.onTouchEnd && D.fireCallback(b.onTouchEnd, D, a), D.callPlugins("onTouchEnd")
        }
    }
    function s(a, b) {
        return a && a.getAttribute("class") && a.getAttribute("class").indexOf(b) > -1
    }
    function t(a) {
        var c = !1;
        do s(a, b.noSwipingClass) && (c = !0), a = a.parentElement;
        while (!c && a.parentElement && !s(a, b.wrapperClass));
        return !c && s(a, b.wrapperClass) && s(a, b.noSwipingClass) && (c = !0), c
    }
    function u(a, b) {
        var c, d = document.createElement("div");
        return d.innerHTML = b, c = d.firstChild, c.className += " " + a, c.outerHTML
    }
    function v(a, c, d) {
        function e() {
            var f = +new Date,
                l = f - g;
            h += i * l / (1e3 / 60), k = "toNext" === j ? h > a : a > h, k ? (D.setWrapperTranslate(Math.ceil(h)), D._DOMAnimating = !0, window.setTimeout(function() {
                e()
            }, 1e3 / 60)) : (b.onSlideChangeEnd && ("to" === c ? d.runCallbacks === !0 && D.fireCallback(b.onSlideChangeEnd, D, j) : D.fireCallback(b.onSlideChangeEnd, D, j)), D.setWrapperTranslate(a), D._DOMAnimating = !1)
        }
        var f = "to" === c && d.speed >= 0 ? d.speed : b.speed,
            g = +new Date;
        if (D.support.transitions || !b.DOMAnimation) D.setWrapperTranslate(a), D.setWrapperTransition(f);
        else {
            var h = D.getWrapperTranslate(),
                i = Math.ceil((a - h) / f * (1e3 / 60)),
                j = h > a ? "toNext" : "toPrev",
                k = "toNext" === j ? h > a : a > h;
            if (D._DOMAnimating) return;
            e()
        }
        D.updateActiveSlide(a), b.onSlideNext && "next" === c && d.runCallbacks === !0 && D.fireCallback(b.onSlideNext, D, a), b.onSlidePrev && "prev" === c && d.runCallbacks === !0 && D.fireCallback(b.onSlidePrev, D, a), b.onSlideReset && "reset" === c && d.runCallbacks === !0 && D.fireCallback(b.onSlideReset, D, a), "next" !== c && "prev" !== c && "to" !== c || d.runCallbacks !== !0 || w(c)
    }
    function w(a) {
        if (D.callPlugins("onSlideChangeStart"), b.onSlideChangeStart) if (b.queueStartCallbacks && D.support.transitions) {
            if (D._queueStartCallbacks) return;
            D._queueStartCallbacks = !0, D.fireCallback(b.onSlideChangeStart, D, a), D.wrapperTransitionEnd(function() {
                D._queueStartCallbacks = !1
            })
        } else D.fireCallback(b.onSlideChangeStart, D, a);
        if (b.onSlideChangeEnd) if (D.support.transitions) if (b.queueEndCallbacks) {
            if (D._queueEndCallbacks) return;
            D._queueEndCallbacks = !0, D.wrapperTransitionEnd(function(c) {
                D.fireCallback(b.onSlideChangeEnd, c, a)
            })
        } else D.wrapperTransitionEnd(function(c) {
            D.fireCallback(b.onSlideChangeEnd, c, a)
        });
        else b.DOMAnimation || setTimeout(function() {
                D.fireCallback(b.onSlideChangeEnd, D, a)
            }, 10)
    }
    function x() {
        var a = D.paginationButtons;
        if (a) for (var b = 0; b < a.length; b++) D.h.removeEventListener(a[b], "click", z)
    }
    function y() {
        var a = D.paginationButtons;
        if (a) for (var b = 0; b < a.length; b++) D.h.addEventListener(a[b], "click", z)
    }
    function z(a) {
        for (var c, d = a.target || a.srcElement, e = D.paginationButtons, f = 0; f < e.length; f++) d === e[f] && (c = f);
        b.autoplay && D.stopAutoplay(!0), D.swipeTo(c)
    }
    function A() {
        ab = setTimeout(function() {
            b.loop ? (D.fixLoop(), D.swipeNext(!0, !0)) : D.swipeNext(!0, !0) || (b.autoplayStopOnLast ? (clearTimeout(ab), ab = void 0) : D.swipeTo(0)), D.wrapperTransitionEnd(function() {
                "undefined" != typeof ab && A()
            })
        }, b.autoplay)
    }
    function B() {
        D.calcSlides(), b.loader.slides.length > 0 && 0 === D.slides.length && D.loadSlides(), b.loop && D.createLoop(), D.init(), f(), b.pagination && D.createPagination(!0), b.loop || b.initialSlide > 0 ? D.swipeTo(b.initialSlide, 0, !1) : D.updateActiveSlide(0), b.autoplay && D.startAutoplay(), D.centerIndex = D.activeIndex, b.onSwiperCreated && D.fireCallback(b.onSwiperCreated, D), D.callPlugins("onSwiperCreated")
    }
    if (!document.body.outerHTML && document.body.__defineGetter__ && HTMLElement) {
        var C = HTMLElement.prototype;
        C.__defineGetter__ && C.__defineGetter__("outerHTML", function() {
            return (new XMLSerializer).serializeToString(this)
        })
    }
    if (window.getComputedStyle || (window.getComputedStyle = function(a) {
            return this.el = a, this.getPropertyValue = function(b) {
                var c = /(\-([a-z]){1})/g;
                return "float" === b && (b = "styleFloat"), c.test(b) && (b = b.replace(c, function() {
                    return arguments[2].toUpperCase()
                })), a.currentStyle[b] ? a.currentStyle[b] : null
            }, this
        }), Array.prototype.indexOf || (Array.prototype.indexOf = function(a, b) {
            for (var c = b || 0, d = this.length; d > c; c++) if (this[c] === a) return c;
            return -1
        }), (document.querySelectorAll || window.jQuery) && "undefined" != typeof a && (a.nodeType || 0 !== c(a).length)) {
        var D = this;
        D.touches = {
            start: 0,
            startX: 0,
            startY: 0,
            current: 0,
            currentX: 0,
            currentY: 0,
            diff: 0,
            abs: 0
        }, D.positions = {
            start: 0,
            abs: 0,
            diff: 0,
            current: 0
        }, D.times = {
            start: 0,
            end: 0
        }, D.id = (new Date).getTime(), D.container = a.nodeType ? a : c(a)[0], D.isTouched = !1, D.isMoved = !1, D.activeIndex = 0, D.centerIndex = 0, D.activeLoaderIndex = 0, D.activeLoopIndex = 0, D.previousIndex = null, D.velocity = 0, D.snapGrid = [], D.slidesGrid = [], D.imagesToLoad = [], D.imagesLoaded = 0, D.wrapperLeft = 0, D.wrapperRight = 0, D.wrapperTop = 0, D.wrapperBottom = 0, D.isAndroid = navigator.userAgent.toLowerCase().indexOf("android") >= 0;
        var E, F, G, H, I, J, K = {
            eventTarget: "wrapper",
            mode: "horizontal",
            touchRatio: 1,
            speed: 300,
            freeMode: !1,
            freeModeFluid: !1,
            momentumRatio: 1,
            momentumBounce: !0,
            momentumBounceRatio: 1,
            slidesPerView: 1,
            slidesPerGroup: 1,
            slidesPerViewFit: !0,
            simulateTouch: !0,
            followFinger: !0,
            shortSwipes: !0,
            longSwipesRatio: .5,
            moveStartThreshold: !1,
            onlyExternal: !1,
            createPagination: !0,
            pagination: !1,
            paginationElement: "span",
            paginationClickable: !1,
            paginationAsRange: !0,
            resistance: !0,
            scrollContainer: !1,
            preventLinks: !0,
            preventLinksPropagation: !1,
            noSwiping: !1,
            noSwipingClass: "swiper-no-swiping",
            initialSlide: 0,
            keyboardControl: !1,
            mousewheelControl: !1,
            mousewheelControlForceToAxis: !1,
            useCSS3Transforms: !0,
            autoplay: !1,
            autoplayDisableOnInteraction: !0,
            autoplayStopOnLast: !1,
            loop: !1,
            loopAdditionalSlides: 0,
            roundLengths: !1,
            calculateHeight: !1,
            cssWidthAndHeight: !1,
            updateOnImagesReady: !0,
            releaseFormElements: !0,
            watchActiveIndex: !1,
            visibilityFullFit: !1,
            offsetPxBefore: 0,
            offsetPxAfter: 0,
            offsetSlidesBefore: 0,
            offsetSlidesAfter: 0,
            centeredSlides: !1,
            queueStartCallbacks: !1,
            queueEndCallbacks: !1,
            autoResize: !0,
            resizeReInit: !1,
            DOMAnimation: !0,
            loader: {
                slides: [],
                slidesHTMLType: "inner",
                surroundGroups: 1,
                logic: "reload",
                loadAllSlides: !1
            },
            swipeToPrev: !0,
            swipeToNext: !0,
            slideElement: "div",
            slideClass: "swiper-slide",
            slideActiveClass: "swiper-slide-active",
            slideVisibleClass: "swiper-slide-visible",
            slideDuplicateClass: "swiper-slide-duplicate",
            wrapperClass: "swiper-wrapper",
            paginationElementClass: "swiper-pagination-switch",
            paginationActiveClass: "swiper-active-switch",
            paginationVisibleClass: "swiper-visible-switch"
        };
        b = b || {};
        for (var L in K) if (L in b && "object" == typeof b[L]) for (var M in K[L]) M in b[L] || (b[L][M] = K[L][M]);
        else L in b || (b[L] = K[L]);
        D.params = b, b.scrollContainer && (b.freeMode = !0, b.freeModeFluid = !0), b.loop && (b.resistance = "100%");
        var N = "horizontal" === b.mode,
            O = ["mousedown", "mousemove", "mouseup"];
        D.browser.ie10 && (O = ["MSPointerDown", "MSPointerMove", "MSPointerUp"]), D.browser.ie11 && (O = ["pointerdown", "pointermove", "pointerup"]), D.touchEvents = {
            touchStart: D.support.touch || !b.simulateTouch ? "touchstart" : O[0],
            touchMove: D.support.touch || !b.simulateTouch ? "touchmove" : O[1],
            touchEnd: D.support.touch || !b.simulateTouch ? "touchend" : O[2]
        };
        for (var P = D.container.childNodes.length - 1; P >= 0; P--) if (D.container.childNodes[P].className) for (var Q = D.container.childNodes[P].className.split(/\s+/), R = 0; R < Q.length; R++) Q[R] === b.wrapperClass && (E = D.container.childNodes[P]);
        D.wrapper = E, D._extendSwiperSlide = function(a) {
            return a.append = function() {
                return b.loop ? a.insertAfter(D.slides.length - D.loopedSlides) : (D.wrapper.appendChild(a), D.reInit()), a
            }, a.prepend = function() {
                return b.loop ? (D.wrapper.insertBefore(a, D.slides[D.loopedSlides]), D.removeLoopedSlides(), D.calcSlides(), D.createLoop()) : D.wrapper.insertBefore(a, D.wrapper.firstChild), D.reInit(), a
            }, a.insertAfter = function(c) {
                if ("undefined" == typeof c) return !1;
                var d;
                return b.loop ? (d = D.slides[c + 1 + D.loopedSlides], d ? D.wrapper.insertBefore(a, d) : D.wrapper.appendChild(a), D.removeLoopedSlides(), D.calcSlides(), D.createLoop()) : (d = D.slides[c + 1], D.wrapper.insertBefore(a, d)), D.reInit(), a
            }, a.clone = function() {
                return D._extendSwiperSlide(a.cloneNode(!0))
            }, a.remove = function() {
                D.wrapper.removeChild(a), D.reInit()
            }, a.html = function(b) {
                return "undefined" == typeof b ? a.innerHTML : (a.innerHTML = b, a)
            }, a.index = function() {
                for (var b, c = D.slides.length - 1; c >= 0; c--) a === D.slides[c] && (b = c);
                return b
            }, a.isActive = function() {
                return a.index() === D.activeIndex ? !0 : !1
            }, a.swiperSlideDataStorage || (a.swiperSlideDataStorage = {}), a.getData = function(b) {
                return a.swiperSlideDataStorage[b]
            }, a.setData = function(b, c) {
                return a.swiperSlideDataStorage[b] = c, a
            }, a.data = function(b, c) {
                return "undefined" == typeof c ? a.getAttribute("data-" + b) : (a.setAttribute("data-" + b, c), a)
            }, a.getWidth = function(b, c) {
                return D.h.getWidth(a, b, c)
            }, a.getHeight = function(b, c) {
                return D.h.getHeight(a, b, c)
            }, a.getOffset = function() {
                return D.h.getOffset(a)
            }, a
        }, D.calcSlides = function(a) {
            var c = D.slides ? D.slides.length : !1;
            D.slides = [], D.displaySlides = [];
            for (var d = 0; d < D.wrapper.childNodes.length; d++) if (D.wrapper.childNodes[d].className) for (var e = D.wrapper.childNodes[d].className, f = e.split(/\s+/), i = 0; i < f.length; i++) f[i] === b.slideClass && D.slides.push(D.wrapper.childNodes[d]);
            for (d = D.slides.length - 1; d >= 0; d--) D._extendSwiperSlide(D.slides[d]);
            c !== !1 && (c !== D.slides.length || a) && (h(), g(), D.updateActiveSlide(), D.params.pagination && D.createPagination(), D.callPlugins("numberOfSlidesChanged"))
        }, D.createSlide = function(a, c, d) {
            c = c || D.params.slideClass, d = d || b.slideElement;
            var e = document.createElement(d);
            return e.innerHTML = a || "", e.className = c, D._extendSwiperSlide(e)
        }, D.appendSlide = function(a, b, c) {
            return a ? a.nodeType ? D._extendSwiperSlide(a).append() : D.createSlide(a, b, c).append() : void 0
        }, D.prependSlide = function(a, b, c) {
            return a ? a.nodeType ? D._extendSwiperSlide(a).prepend() : D.createSlide(a, b, c).prepend() : void 0
        }, D.insertSlideAfter = function(a, b, c, d) {
            return "undefined" == typeof a ? !1 : b.nodeType ? D._extendSwiperSlide(b).insertAfter(a) : D.createSlide(b, c, d).insertAfter(a)
        }, D.removeSlide = function(a) {
            if (D.slides[a]) {
                if (b.loop) {
                    if (!D.slides[a + D.loopedSlides]) return !1;
                    D.slides[a + D.loopedSlides].remove(), D.removeLoopedSlides(), D.calcSlides(), D.createLoop()
                } else D.slides[a].remove();
                return !0
            }
            return !1
        }, D.removeLastSlide = function() {
            return D.slides.length > 0 ? (b.loop ? (D.slides[D.slides.length - 1 - D.loopedSlides].remove(), D.removeLoopedSlides(), D.calcSlides(), D.createLoop()) : D.slides[D.slides.length - 1].remove(), !0) : !1
        }, D.removeAllSlides = function() {
            for (var a = D.slides.length, b = D.slides.length - 1; b >= 0; b--) D.slides[b].remove(), b === a - 1 && D.setWrapperTranslate(0)
        }, D.getSlide = function(a) {
            return D.slides[a]
        }, D.getLastSlide = function() {
            return D.slides[D.slides.length - 1]
        }, D.getFirstSlide = function() {
            return D.slides[0]
        }, D.activeSlide = function() {
            return D.slides[D.activeIndex]
        }, D.fireCallback = function() {
            var a = arguments[0];
            if ("[object Array]" === Object.prototype.toString.call(a)) for (var c = 0; c < a.length; c++)"function" == typeof a[c] && a[c](arguments[1], arguments[2], arguments[3], arguments[4], arguments[5]);
            else "[object String]" === Object.prototype.toString.call(a) ? b["on" + a] && D.fireCallback(b["on" + a], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5]) : a(arguments[1], arguments[2], arguments[3], arguments[4], arguments[5])
        }, D.addCallback = function(a, b) {
            var c, e = this;
            return e.params["on" + a] ? d(this.params["on" + a]) ? this.params["on" + a].push(b) : "function" == typeof this.params["on" + a] ? (c = this.params["on" + a], this.params["on" + a] = [], this.params["on" + a].push(c), this.params["on" + a].push(b)) : void 0 : (this.params["on" + a] = [], this.params["on" + a].push(b))
        }, D.removeCallbacks = function(a) {
            D.params["on" + a] && (D.params["on" + a] = null)
        };
        var S = [];
        for (var T in D.plugins) if (b[T]) {
            var U = D.plugins[T](D, b[T]);
            U && S.push(U)
        }
        D.callPlugins = function(a, b) {
            b || (b = {});
            for (var c = 0; c < S.length; c++) a in S[c] && S[c][a](b)
        }, !D.browser.ie10 && !D.browser.ie11 || b.onlyExternal || D.wrapper.classList.add("swiper-wp8-" + (N ? "horizontal" : "vertical")), b.freeMode && (D.container.className += " swiper-free-mode"), D.initialized = !1, D.init = function(a, c) {
            var d = D.h.getWidth(D.container, !1, b.roundLengths),
                e = D.h.getHeight(D.container, !1, b.roundLengths);
            if (d !== D.width || e !== D.height || a) {
                D.width = d, D.height = e;
                var f, g, h, i, j, k, l;
                J = N ? d : e;
                var m = D.wrapper;
                if (a && D.calcSlides(c), "auto" === b.slidesPerView) {
                    var n = 0,
                        o = 0;
                    b.slidesOffset > 0 && (m.style.paddingLeft = "", m.style.paddingRight = "", m.style.paddingTop = "", m.style.paddingBottom = ""), m.style.width = "", m.style.height = "", b.offsetPxBefore > 0 && (N ? D.wrapperLeft = b.offsetPxBefore : D.wrapperTop = b.offsetPxBefore), b.offsetPxAfter > 0 && (N ? D.wrapperRight = b.offsetPxAfter : D.wrapperBottom = b.offsetPxAfter), b.centeredSlides && (N ? (D.wrapperLeft = (J - this.slides[0].getWidth(!0, b.roundLengths)) / 2, D.wrapperRight = (J - D.slides[D.slides.length - 1].getWidth(!0, b.roundLengths)) / 2) : (D.wrapperTop = (J - D.slides[0].getHeight(!0, b.roundLengths)) / 2, D.wrapperBottom = (J - D.slides[D.slides.length - 1].getHeight(!0, b.roundLengths)) / 2)), N ? (D.wrapperLeft >= 0 && (m.style.paddingLeft = D.wrapperLeft + "px"), D.wrapperRight >= 0 && (m.style.paddingRight = D.wrapperRight + "px")) : (D.wrapperTop >= 0 && (m.style.paddingTop = D.wrapperTop + "px"), D.wrapperBottom >= 0 && (m.style.paddingBottom = D.wrapperBottom + "px")), k = 0;
                    var p = 0;
                    for (D.snapGrid = [], D.slidesGrid = [], h = 0, l = 0; l < D.slides.length; l++) {
                        f = D.slides[l].getWidth(!0, b.roundLengths), g = D.slides[l].getHeight(!0, b.roundLengths), b.calculateHeight && (h = Math.max(h, g));
                        var q = N ? f : g;
                        if (b.centeredSlides) {
                            var r = l === D.slides.length - 1 ? 0 : D.slides[l + 1].getWidth(!0, b.roundLengths),
                                s = l === D.slides.length - 1 ? 0 : D.slides[l + 1].getHeight(!0, b.roundLengths),
                                t = N ? r : s;
                            if (q > J) {
                                if (b.slidesPerViewFit) D.snapGrid.push(k + D.wrapperLeft), D.snapGrid.push(k + q - J + D.wrapperLeft);
                                else for (var u = 0; u <= Math.floor(q / (J + D.wrapperLeft)); u++) D.snapGrid.push(0 === u ? k + D.wrapperLeft : k + D.wrapperLeft + J * u);
                                D.slidesGrid.push(k + D.wrapperLeft)
                            } else D.snapGrid.push(p), D.slidesGrid.push(p);
                            p += q / 2 + t / 2
                        } else {
                            if (q > J) if (b.slidesPerViewFit) D.snapGrid.push(k), D.snapGrid.push(k + q - J);
                            else if (0 !== J) for (var v = 0; v <= Math.floor(q / J); v++) D.snapGrid.push(k + J * v);
                            else D.snapGrid.push(k);
                            else D.snapGrid.push(k);
                            D.slidesGrid.push(k)
                        }
                        k += q, n += f, o += g
                    }
                    b.calculateHeight && (D.height = h), N ? (G = n + D.wrapperRight + D.wrapperLeft, b.cssWidthAndHeight && "height" !== b.cssWidthAndHeight || (m.style.width = n + "px"), b.cssWidthAndHeight && "width" !== b.cssWidthAndHeight || (m.style.height = D.height + "px")) : (b.cssWidthAndHeight && "height" !== b.cssWidthAndHeight || (m.style.width = D.width + "px"), b.cssWidthAndHeight && "width" !== b.cssWidthAndHeight || (m.style.height = o + "px"), G = o + D.wrapperTop + D.wrapperBottom)
                } else if (b.scrollContainer) m.style.width = "", m.style.height = "", i = D.slides[0].getWidth(!0, b.roundLengths), j = D.slides[0].getHeight(!0, b.roundLengths), G = N ? i : j, m.style.width = i + "px", m.style.height = j + "px", F = N ? i : j;
                else {
                    if (b.calculateHeight) {
                        for (h = 0, j = 0, N || (D.container.style.height = ""), m.style.height = "", l = 0; l < D.slides.length; l++) D.slides[l].style.height = "", h = Math.max(D.slides[l].getHeight(!0), h), N || (j += D.slides[l].getHeight(!0));
                        g = h, D.height = g, N ? j = g : (J = g, D.container.style.height = J + "px")
                    } else g = N ? D.height : D.height / b.slidesPerView, b.roundLengths && (g = Math.ceil(g)), j = N ? D.height : D.slides.length * g;
                    for (f = N ? D.width / b.slidesPerView : D.width, b.roundLengths && (f = Math.ceil(f)), i = N ? D.slides.length * f : D.width, F = N ? f : g, b.offsetSlidesBefore > 0 && (N ? D.wrapperLeft = F * b.offsetSlidesBefore : D.wrapperTop = F * b.offsetSlidesBefore), b.offsetSlidesAfter > 0 && (N ? D.wrapperRight = F * b.offsetSlidesAfter : D.wrapperBottom = F * b.offsetSlidesAfter), b.offsetPxBefore > 0 && (N ? D.wrapperLeft = b.offsetPxBefore : D.wrapperTop = b.offsetPxBefore), b.offsetPxAfter > 0 && (N ? D.wrapperRight = b.offsetPxAfter : D.wrapperBottom = b.offsetPxAfter), b.centeredSlides && (N ? (D.wrapperLeft = (J - F) / 2, D.wrapperRight = (J - F) / 2) : (D.wrapperTop = (J - F) / 2, D.wrapperBottom = (J - F) / 2)), N ? (D.wrapperLeft > 0 && (m.style.paddingLeft = D.wrapperLeft + "px"), D.wrapperRight > 0 && (m.style.paddingRight = D.wrapperRight + "px")) : (D.wrapperTop > 0 && (m.style.paddingTop = D.wrapperTop + "px"), D.wrapperBottom > 0 && (m.style.paddingBottom = D.wrapperBottom + "px")), G = N ? i + D.wrapperRight + D.wrapperLeft : j + D.wrapperTop + D.wrapperBottom, parseFloat(i) > 0 && (!b.cssWidthAndHeight || "height" === b.cssWidthAndHeight) && (m.style.width = i + "px"), parseFloat(j) > 0 && (!b.cssWidthAndHeight || "width" === b.cssWidthAndHeight) && (m.style.height = j + "px"), k = 0, D.snapGrid = [], D.slidesGrid = [], l = 0; l < D.slides.length; l++) D.snapGrid.push(k), D.slidesGrid.push(k), k += F, parseFloat(f) > 0 && (!b.cssWidthAndHeight || "height" === b.cssWidthAndHeight) && (D.slides[l].style.width = f + "px"), parseFloat(g) > 0 && (!b.cssWidthAndHeight || "width" === b.cssWidthAndHeight) && (D.slides[l].style.height = g + "px")
                }
                D.initialized ? (D.callPlugins("onInit"), b.onInit && D.fireCallback(b.onInit, D)) : (D.callPlugins("onFirstInit"), b.onFirstInit && D.fireCallback(b.onFirstInit, D)), D.initialized = !0
            }
        }, D.reInit = function(a) {
            D.init(!0, a)
        }, D.resizeFix = function(a) {
            D.callPlugins("beforeResizeFix"), D.init(b.resizeReInit || a), b.freeMode ? D.getWrapperTranslate() < -e() && (D.setWrapperTransition(0), D.setWrapperTranslate(-e())) : (D.swipeTo(b.loop ? D.activeLoopIndex : D.activeIndex, 0, !1), b.autoplay && (D.support.transitions && "undefined" != typeof ab ? "undefined" != typeof ab && (clearTimeout(ab), ab = void 0, D.startAutoplay()) : "undefined" != typeof bb && (clearInterval(bb), bb = void 0, D.startAutoplay()))), D.callPlugins("afterResizeFix")
        }, D.destroy = function(a) {
            var c = D.h.removeEventListener,
                d = "wrapper" === b.eventTarget ? D.wrapper : D.container;
            if (D.browser.ie10 || D.browser.ie11 ? (c(d, D.touchEvents.touchStart, p), c(document, D.touchEvents.touchMove, q), c(document, D.touchEvents.touchEnd, r)) : (D.support.touch && (c(d, "touchstart", p), c(d, "touchmove", q), c(d, "touchend", r)), b.simulateTouch && (c(d, "mousedown", p), c(document, "mousemove", q), c(document, "mouseup", r))), b.autoResize && c(window, "resize", D.resizeFix), h(), b.paginationClickable && x(), b.mousewheelControl && D._wheelEvent && c(D.container, D._wheelEvent, j), b.keyboardControl && c(document, "keydown", i), b.autoplay && D.stopAutoplay(), a) {
                D.wrapper.removeAttribute("style");
                for (var e = 0; e < D.slides.length; e++) D.slides[e].removeAttribute("style")
            }
            D.callPlugins("onDestroy"), window.jQuery && window.jQuery(D.container).data("swiper") && window.jQuery(D.container).removeData("swiper"), window.Zepto && window.Zepto(D.container).data("swiper") && window.Zepto(D.container).removeData("swiper"), D = null
        }, D.disableKeyboardControl = function() {
            b.keyboardControl = !1, D.h.removeEventListener(document, "keydown", i)
        }, D.enableKeyboardControl = function() {
            b.keyboardControl = !0, D.h.addEventListener(document, "keydown", i)
        };
        var V = (new Date).getTime();
        if (D.disableMousewheelControl = function() {
                return D._wheelEvent ? (b.mousewheelControl = !1, D.h.removeEventListener(D.container, D._wheelEvent, j), !0) : !1
            }, D.enableMousewheelControl = function() {
                return D._wheelEvent ? (b.mousewheelControl = !0, D.h.addEventListener(D.container, D._wheelEvent, j), !0) : !1
            }, b.grabCursor) {
            var W = D.container.style;
            W.cursor = "move", W.cursor = "grab", W.cursor = "-moz-grab", W.cursor = "-webkit-grab"
        }
        D.allowSlideClick = !0, D.allowLinks = !0;
        var X, Y, Z, $ = !1,
            _ = !0;
        D.swipeNext = function(a, c) {
            "undefined" == typeof a && (a = !0), !c && b.loop && D.fixLoop(), !c && b.autoplay && D.stopAutoplay(!0), D.callPlugins("onSwipeNext");
            var d = D.getWrapperTranslate().toFixed(2),
                f = d;
            if ("auto" === b.slidesPerView) {
                for (var g = 0; g < D.snapGrid.length; g++) if (-d >= D.snapGrid[g].toFixed(2) && -d < D.snapGrid[g + 1].toFixed(2)) {
                    f = -D.snapGrid[g + 1];
                    break
                }
            } else {
                var h = F * b.slidesPerGroup;
                f = -(Math.floor(Math.abs(d) / Math.floor(h)) * h + h)
            }
            return f < -e() && (f = -e()), f === d ? !1 : (v(f, "next", {
                runCallbacks: a
            }), !0)
        }, D.swipePrev = function(a, c) {
            "undefined" == typeof a && (a = !0), !c && b.loop && D.fixLoop(), !c && b.autoplay && D.stopAutoplay(!0), D.callPlugins("onSwipePrev");
            var d, e = Math.ceil(D.getWrapperTranslate());
            if ("auto" === b.slidesPerView) {
                d = 0;
                for (var f = 1; f < D.snapGrid.length; f++) {
                    if (-e === D.snapGrid[f]) {
                        d = -D.snapGrid[f - 1];
                        break
                    }
                    if (-e > D.snapGrid[f] && -e < D.snapGrid[f + 1]) {
                        d = -D.snapGrid[f];
                        break
                    }
                }
            } else {
                var g = F * b.slidesPerGroup;
                d = -(Math.ceil(-e / g) - 1) * g
            }
            return d > 0 && (d = 0), d === e ? !1 : (v(d, "prev", {
                runCallbacks: a
            }), !0)
        }, D.swipeReset = function(a) {
            "undefined" == typeof a && (a = !0), D.callPlugins("onSwipeReset"); {
                var c, d = D.getWrapperTranslate(),
                    f = F * b.slidesPerGroup; - e()
            }
            if ("auto" === b.slidesPerView) {
                c = 0;
                for (var g = 0; g < D.snapGrid.length; g++) {
                    if (-d === D.snapGrid[g]) return;
                    if (-d >= D.snapGrid[g] && -d < D.snapGrid[g + 1]) {
                        c = D.positions.diff > 0 ? -D.snapGrid[g + 1] : -D.snapGrid[g];
                        break
                    }
                } - d >= D.snapGrid[D.snapGrid.length - 1] && (c = -D.snapGrid[D.snapGrid.length - 1]), d <= -e() && (c = -e())
            } else c = 0 > d ? Math.round(d / f) * f : 0, d <= -e() && (c = -e());
            return b.scrollContainer && (c = 0 > d ? d : 0), c < -e() && (c = -e()), b.scrollContainer && J > F && (c = 0), c === d ? !1 : (v(c, "reset", {
                runCallbacks: a
            }), !0)
        }, D.swipeTo = function(a, c, d) {
            a = parseInt(a, 10), D.callPlugins("onSwipeTo", {
                index: a,
                speed: c
            }), b.loop && (a += D.loopedSlides);
            var f = D.getWrapperTranslate();
            if (!(a > D.slides.length - 1 || 0 > a)) {
                var g;
                return g = "auto" === b.slidesPerView ? -D.slidesGrid[a] : -a * F, g < -e() && (g = -e()), g === f ? !1 : ("undefined" == typeof d && (d = !0), v(g, "to", {
                    index: a,
                    speed: c,
                    runCallbacks: d
                }), !0)
            }
        }, D._queueStartCallbacks = !1, D._queueEndCallbacks = !1, D.updateActiveSlide = function(a) {
            if (D.initialized && 0 !== D.slides.length) {
                D.previousIndex = D.activeIndex, "undefined" == typeof a && (a = D.getWrapperTranslate()), a > 0 && (a = 0);
                var c;
                if ("auto" === b.slidesPerView) {
                    if (D.activeIndex = D.slidesGrid.indexOf(-a), D.activeIndex < 0) {
                        for (c = 0; c < D.slidesGrid.length - 1 && !(-a > D.slidesGrid[c] && -a < D.slidesGrid[c + 1]); c++);
                        var d = Math.abs(D.slidesGrid[c] + a),
                            e = Math.abs(D.slidesGrid[c + 1] + a);
                        D.activeIndex = e >= d ? c : c + 1
                    }
                } else D.activeIndex = Math[b.visibilityFullFit ? "ceil" : "round"](-a / F);
                if (D.activeIndex === D.slides.length && (D.activeIndex = D.slides.length - 1), D.activeIndex < 0 && (D.activeIndex = 0), D.slides[D.activeIndex]) {
                    if (D.calcVisibleSlides(a), D.support.classList) {
                        var f;
                        for (c = 0; c < D.slides.length; c++) f = D.slides[c], f.classList.remove(b.slideActiveClass), D.visibleSlides.indexOf(f) >= 0 ? f.classList.add(b.slideVisibleClass) : f.classList.remove(b.slideVisibleClass);
                        D.slides[D.activeIndex].classList.add(b.slideActiveClass)
                    } else {
                        var g = new RegExp("\\s*" + b.slideActiveClass),
                            h = new RegExp("\\s*" + b.slideVisibleClass);
                        for (c = 0; c < D.slides.length; c++) D.slides[c].className = D.slides[c].className.replace(g, "").replace(h, ""), D.visibleSlides.indexOf(D.slides[c]) >= 0 && (D.slides[c].className += " " + b.slideVisibleClass);
                        D.slides[D.activeIndex].className += " " + b.slideActiveClass
                    }
                    if (b.loop) {
                        var i = D.loopedSlides;
                        D.activeLoopIndex = D.activeIndex - i, D.activeLoopIndex >= D.slides.length - 2 * i && (D.activeLoopIndex = D.slides.length - 2 * i - D.activeLoopIndex), D.activeLoopIndex < 0 && (D.activeLoopIndex = D.slides.length - 2 * i + D.activeLoopIndex), D.activeLoopIndex < 0 && (D.activeLoopIndex = 0)
                    } else D.activeLoopIndex = D.activeIndex;
                    b.pagination && D.updatePagination(a)
                }
            }
        }, D.createPagination = function(a) {
            if (b.paginationClickable && D.paginationButtons && x(), D.paginationContainer = b.pagination.nodeType ? b.pagination : c(b.pagination)[0], b.createPagination) {
                var d = "",
                    e = D.slides.length,
                    f = e;
                b.loop && (f -= 2 * D.loopedSlides);
                for (var g = 0; f > g; g++) d += "<" + b.paginationElement + ' class="' + b.paginationElementClass + '"></' + b.paginationElement + ">";
                D.paginationContainer.innerHTML = d
            }
            D.paginationButtons = c("." + b.paginationElementClass, D.paginationContainer), a || D.updatePagination(), D.callPlugins("onCreatePagination"), b.paginationClickable && y()
        }, D.updatePagination = function(a) {
            if (b.pagination && !(D.slides.length < 1)) {
                var d = c("." + b.paginationActiveClass, D.paginationContainer);
                if (d) {
                    var e = D.paginationButtons;
                    if (0 !== e.length) {
                        for (var f = 0; f < e.length; f++) e[f].className = b.paginationElementClass;
                        var g = b.loop ? D.loopedSlides : 0;
                        if (b.paginationAsRange) {
                            D.visibleSlides || D.calcVisibleSlides(a);
                            var h, i = [];
                            for (h = 0; h < D.visibleSlides.length; h++) {
                                var j = D.slides.indexOf(D.visibleSlides[h]) - g;
                                b.loop && 0 > j && (j = D.slides.length - 2 * D.loopedSlides + j), b.loop && j >= D.slides.length - 2 * D.loopedSlides && (j = D.slides.length - 2 * D.loopedSlides - j, j = Math.abs(j)), i.push(j)
                            }
                            for (h = 0; h < i.length; h++) e[i[h]] && (e[i[h]].className += " " + b.paginationVisibleClass);
                            b.loop ? void 0 !== e[D.activeLoopIndex] && (e[D.activeLoopIndex].className += " " + b.paginationActiveClass) : e[D.activeIndex] && (e[D.activeIndex].className += " " + b.paginationActiveClass)
                        } else b.loop ? e[D.activeLoopIndex] && (e[D.activeLoopIndex].className += " " + b.paginationActiveClass + " " + b.paginationVisibleClass) : e[D.activeIndex] && (e[D.activeIndex].className += " " + b.paginationActiveClass + " " + b.paginationVisibleClass)
                    }
                }
            }
        }, D.calcVisibleSlides = function(a) {
            var c = [],
                d = 0,
                e = 0,
                f = 0;
            N && D.wrapperLeft > 0 && (a += D.wrapperLeft), !N && D.wrapperTop > 0 && (a += D.wrapperTop);
            for (var g = 0; g < D.slides.length; g++) {
                d += e, e = "auto" === b.slidesPerView ? N ? D.h.getWidth(D.slides[g], !0, b.roundLengths) : D.h.getHeight(D.slides[g], !0, b.roundLengths) : F, f = d + e;
                var h = !1;
                b.visibilityFullFit ? (d >= -a && -a + J >= f && (h = !0), -a >= d && f >= -a + J && (h = !0)) : (f > -a && -a + J >= f && (h = !0), d >= -a && -a + J > d && (h = !0), -a > d && f > -a + J && (h = !0)), h && c.push(D.slides[g])
            }
            0 === c.length && (c = [D.slides[D.activeIndex]]), D.visibleSlides = c
        };
        var ab, bb;
        D.startAutoplay = function() {
            if (D.support.transitions) {
                if ("undefined" != typeof ab) return !1;
                if (!b.autoplay) return;
                D.callPlugins("onAutoplayStart"), b.onAutoplayStart && D.fireCallback(b.onAutoplayStart, D), A()
            } else {
                if ("undefined" != typeof bb) return !1;
                if (!b.autoplay) return;
                D.callPlugins("onAutoplayStart"), b.onAutoplayStart && D.fireCallback(b.onAutoplayStart, D), bb = setInterval(function() {
                    b.loop ? (D.fixLoop(), D.swipeNext(!0, !0)) : D.swipeNext(!0, !0) || (b.autoplayStopOnLast ? (clearInterval(bb), bb = void 0) : D.swipeTo(0))
                }, b.autoplay)
            }
        }, D.stopAutoplay = function(a) {
            if (D.support.transitions) {
                if (!ab) return;
                ab && clearTimeout(ab), ab = void 0, a && !b.autoplayDisableOnInteraction && D.wrapperTransitionEnd(function() {
                    A()
                }), D.callPlugins("onAutoplayStop"), b.onAutoplayStop && D.fireCallback(b.onAutoplayStop, D)
            } else bb && clearInterval(bb), bb = void 0, D.callPlugins("onAutoplayStop"), b.onAutoplayStop && D.fireCallback(b.onAutoplayStop, D)
        }, D.loopCreated = !1, D.removeLoopedSlides = function() {
            if (D.loopCreated) for (var a = 0; a < D.slides.length; a++) D.slides[a].getData("looped") === !0 && D.wrapper.removeChild(D.slides[a])
        }, D.createLoop = function() {
            if (0 !== D.slides.length) {
                D.loopedSlides = "auto" === b.slidesPerView ? b.loopedSlides || 1 : b.slidesPerView + b.loopAdditionalSlides, D.loopedSlides > D.slides.length && (D.loopedSlides = D.slides.length);
                var a, c = "",
                    d = "",
                    e = "",
                    f = D.slides.length,
                    g = Math.floor(D.loopedSlides / f),
                    h = D.loopedSlides % f;
                for (a = 0; g * f > a; a++) {
                    var i = a;
                    if (a >= f) {
                        var j = Math.floor(a / f);
                        i = a - f * j
                    }
                    e += D.slides[i].outerHTML
                }
                for (a = 0; h > a; a++) d += u(b.slideDuplicateClass, D.slides[a].outerHTML);
                for (a = f - h; f > a; a++) c += u(b.slideDuplicateClass, D.slides[a].outerHTML);
                var k = c + e + E.innerHTML + e + d;
                for (E.innerHTML = k, D.loopCreated = !0, D.calcSlides(), a = 0; a < D.slides.length; a++)(a < D.loopedSlides || a >= D.slides.length - D.loopedSlides) && D.slides[a].setData("looped", !0);
                D.callPlugins("onCreateLoop")
            }
        }, D.fixLoop = function() {
            var a;
            D.activeIndex < D.loopedSlides ? (a = D.slides.length - 3 * D.loopedSlides + D.activeIndex, D.swipeTo(a, 0, !1)) : ("auto" === b.slidesPerView && D.activeIndex >= 2 * D.loopedSlides || D.activeIndex > D.slides.length - 2 * b.slidesPerView) && (a = -D.slides.length + D.activeIndex + D.loopedSlides, D.swipeTo(a, 0, !1))
        }, D.loadSlides = function() {
            var a = "";
            D.activeLoaderIndex = 0;
            for (var c = b.loader.slides, d = b.loader.loadAllSlides ? c.length : b.slidesPerView * (1 + b.loader.surroundGroups), e = 0; d > e; e++) a += "outer" === b.loader.slidesHTMLType ? c[e] : "<" + b.slideElement + ' class="' + b.slideClass + '" data-swiperindex="' + e + '">' + c[e] + "</" + b.slideElement + ">";
            D.wrapper.innerHTML = a, D.calcSlides(!0), b.loader.loadAllSlides || D.wrapperTransitionEnd(D.reloadSlides, !0)
        }, D.reloadSlides = function() {
            var a = b.loader.slides,
                c = parseInt(D.activeSlide().data("swiperindex"), 10);
            if (!(0 > c || c > a.length - 1)) {
                D.activeLoaderIndex = c;
                var d = Math.max(0, c - b.slidesPerView * b.loader.surroundGroups),
                    e = Math.min(c + b.slidesPerView * (1 + b.loader.surroundGroups) - 1, a.length - 1);
                if (c > 0) {
                    var f = -F * (c - d);
                    D.setWrapperTranslate(f), D.setWrapperTransition(0)
                }
                var g;
                if ("reload" === b.loader.logic) {
                    D.wrapper.innerHTML = "";
                    var h = "";
                    for (g = d; e >= g; g++) h += "outer" === b.loader.slidesHTMLType ? a[g] : "<" + b.slideElement + ' class="' + b.slideClass + '" data-swiperindex="' + g + '">' + a[g] + "</" + b.slideElement + ">";
                    D.wrapper.innerHTML = h
                } else {
                    var i = 1e3,
                        j = 0;
                    for (g = 0; g < D.slides.length; g++) {
                        var k = D.slides[g].data("swiperindex");
                        d > k || k > e ? D.wrapper.removeChild(D.slides[g]) : (i = Math.min(k, i), j = Math.max(k, j))
                    }
                    for (g = d; e >= g; g++) {
                        var l;
                        i > g && (l = document.createElement(b.slideElement), l.className = b.slideClass, l.setAttribute("data-swiperindex", g), l.innerHTML = a[g], D.wrapper.insertBefore(l, D.wrapper.firstChild)), g > j && (l = document.createElement(b.slideElement), l.className = b.slideClass, l.setAttribute("data-swiperindex", g), l.innerHTML = a[g], D.wrapper.appendChild(l))
                    }
                }
                D.reInit(!0)
            }
        }, B()
    }
};
Swiper.prototype = {
    plugins: {},
    wrapperTransitionEnd: function(a, b) {
        "use strict";

        function c(h) {
            if (h.target === f && (a(e), e.params.queueEndCallbacks && (e._queueEndCallbacks = !1), !b)) for (d = 0; d < g.length; d++) e.h.removeEventListener(f, g[d], c)
        }
        var d, e = this,
            f = e.wrapper,
            g = ["webkitTransitionEnd", "transitionend", "oTransitionEnd", "MSTransitionEnd", "msTransitionEnd"];
        if (a) for (d = 0; d < g.length; d++) e.h.addEventListener(f, g[d], c)
    },
    getWrapperTranslate: function(a) {
        "use strict";
        var b, c, d, e, f = this.wrapper;
        return "undefined" == typeof a && (a = "horizontal" === this.params.mode ? "x" : "y"), this.support.transforms && this.params.useCSS3Transforms ? (d = window.getComputedStyle(f, null), window.WebKitCSSMatrix ? e = new WebKitCSSMatrix("none" === d.webkitTransform ? "" : d.webkitTransform) : (e = d.MozTransform || d.OTransform || d.MsTransform || d.msTransform || d.transform || d.getPropertyValue("transform").replace("translate(", "matrix(1, 0, 0, 1,"), b = e.toString().split(",")), "x" === a && (c = window.WebKitCSSMatrix ? e.m41 : parseFloat(16 === b.length ? b[12] : b[4])), "y" === a && (c = window.WebKitCSSMatrix ? e.m42 : parseFloat(16 === b.length ? b[13] : b[5]))) : ("x" === a && (c = parseFloat(f.style.left, 10) || 0), "y" === a && (c = parseFloat(f.style.top, 10) || 0)), c || 0
    },
    setWrapperTranslate: function(a, b, c) {
        "use strict";
        var d, e = this.wrapper.style,
            f = {
                x: 0,
                y: 0,
                z: 0
            };
        3 === arguments.length ? (f.x = a, f.y = b, f.z = c) : ("undefined" == typeof b && (b = "horizontal" === this.params.mode ? "x" : "y"), f[b] = a), this.support.transforms && this.params.useCSS3Transforms ? (d = this.support.transforms3d ? "translate3d(" + f.x + "px, " + f.y + "px, " + f.z + "px)" : "translate(" + f.x + "px, " + f.y + "px)", e.webkitTransform = e.MsTransform = e.msTransform = e.MozTransform = e.OTransform = e.transform = d) : (e.left = f.x + "px", e.top = f.y + "px"), this.callPlugins("onSetWrapperTransform", f), this.params.onSetWrapperTransform && this.fireCallback(this.params.onSetWrapperTransform, this, f)
    },
    setWrapperTransition: function(a) {
        "use strict";
        var b = this.wrapper.style;
        b.webkitTransitionDuration = b.MsTransitionDuration = b.msTransitionDuration = b.MozTransitionDuration = b.OTransitionDuration = b.transitionDuration = a / 1e3 + "s", this.callPlugins("onSetWrapperTransition", {
            duration: a
        }), this.params.onSetWrapperTransition && this.fireCallback(this.params.onSetWrapperTransition, this, a)
    },
    h: {
        getWidth: function(a, b, c) {
            "use strict";
            var d = window.getComputedStyle(a, null).getPropertyValue("width"),
                e = parseFloat(d);
            return (isNaN(e) || d.indexOf("%") > 0 || 0 > e) && (e = a.offsetWidth - parseFloat(window.getComputedStyle(a, null).getPropertyValue("padding-left")) - parseFloat(window.getComputedStyle(a, null).getPropertyValue("padding-right"))), b && (e += parseFloat(window.getComputedStyle(a, null).getPropertyValue("padding-left")) + parseFloat(window.getComputedStyle(a, null).getPropertyValue("padding-right"))), c ? Math.ceil(e) : e
        },
        getHeight: function(a, b, c) {
            "use strict";
            if (b) return a.offsetHeight;
            var d = window.getComputedStyle(a, null).getPropertyValue("height"),
                e = parseFloat(d);
            return (isNaN(e) || d.indexOf("%") > 0 || 0 > e) && (e = a.offsetHeight - parseFloat(window.getComputedStyle(a, null).getPropertyValue("padding-top")) - parseFloat(window.getComputedStyle(a, null).getPropertyValue("padding-bottom"))), b && (e += parseFloat(window.getComputedStyle(a, null).getPropertyValue("padding-top")) + parseFloat(window.getComputedStyle(a, null).getPropertyValue("padding-bottom"))), c ? Math.ceil(e) : e
        },
        getOffset: function(a) {
            "use strict";
            var b = a.getBoundingClientRect(),
                c = document.body,
                d = a.clientTop || c.clientTop || 0,
                e = a.clientLeft || c.clientLeft || 0,
                f = window.pageYOffset || a.scrollTop,
                g = window.pageXOffset || a.scrollLeft;
            return document.documentElement && !window.pageYOffset && (f = document.documentElement.scrollTop, g = document.documentElement.scrollLeft), {
                top: b.top + f - d,
                left: b.left + g - e
            }
        },
        windowWidth: function() {
            "use strict";
            return window.innerWidth ? window.innerWidth : document.documentElement && document.documentElement.clientWidth ? document.documentElement.clientWidth : void 0
        },
        windowHeight: function() {
            "use strict";
            return window.innerHeight ? window.innerHeight : document.documentElement && document.documentElement.clientHeight ? document.documentElement.clientHeight : void 0
        },
        windowScroll: function() {
            "use strict";
            return "undefined" != typeof pageYOffset ? {
                left: window.pageXOffset,
                top: window.pageYOffset
            } : document.documentElement ? {
                left: document.documentElement.scrollLeft,
                top: document.documentElement.scrollTop
            } : void 0
        },
        addEventListener: function(a, b, c, d) {
            "use strict";
            "undefined" == typeof d && (d = !1), a.addEventListener ? a.addEventListener(b, c, d) : a.attachEvent && a.attachEvent("on" + b, c)
        },
        removeEventListener: function(a, b, c, d) {
            "use strict";
            "undefined" == typeof d && (d = !1), a.removeEventListener ? a.removeEventListener(b, c, d) : a.detachEvent && a.detachEvent("on" + b, c)
        }
    },
    setTransform: function(a, b) {
        "use strict";
        var c = a.style;
        c.webkitTransform = c.MsTransform = c.msTransform = c.MozTransform = c.OTransform = c.transform = b
    },
    setTranslate: function(a, b) {
        "use strict";
        var c = a.style,
            d = {
                x: b.x || 0,
                y: b.y || 0,
                z: b.z || 0
            },
            e = this.support.transforms3d ? "translate3d(" + d.x + "px," + d.y + "px," + d.z + "px)" : "translate(" + d.x + "px," + d.y + "px)";
        c.webkitTransform = c.MsTransform = c.msTransform = c.MozTransform = c.OTransform = c.transform = e, this.support.transforms || (c.left = d.x + "px", c.top = d.y + "px")
    },
    setTransition: function(a, b) {
        "use strict";
        var c = a.style;
        c.webkitTransitionDuration = c.MsTransitionDuration = c.msTransitionDuration = c.MozTransitionDuration = c.OTransitionDuration = c.transitionDuration = b + "ms"
    },
    support: {
        touch: window.Modernizr && Modernizr.touch === !0 ||
        function() {
            "use strict";
            return !!("ontouchstart" in window || window.DocumentTouch && document instanceof DocumentTouch)
        }(),
        transforms3d: window.Modernizr && Modernizr.csstransforms3d === !0 ||
        function() {
            "use strict";
            var a = document.createElement("div").style;
            return "webkitPerspective" in a || "MozPerspective" in a || "OPerspective" in a || "MsPerspective" in a || "perspective" in a
        }(),
        transforms: window.Modernizr && Modernizr.csstransforms === !0 ||
        function() {
            "use strict";
            var a = document.createElement("div").style;
            return "transform" in a || "WebkitTransform" in a || "MozTransform" in a || "msTransform" in a || "MsTransform" in a || "OTransform" in a
        }(),
        transitions: window.Modernizr && Modernizr.csstransitions === !0 ||
        function() {
            "use strict";
            var a = document.createElement("div").style;
            return "transition" in a || "WebkitTransition" in a || "MozTransition" in a || "msTransition" in a || "MsTransition" in a || "OTransition" in a
        }(),
        classList: function() {
            "use strict";
            var a = document.createElement("div");
            return "classList" in a
        }()
    },
    browser: {
        ie8: function() {
            "use strict";
            var a = -1;
            if ("Microsoft Internet Explorer" === navigator.appName) {
                var b = navigator.userAgent,
                    c = new RegExp(/MSIE ([0-9]{1,}[\.0-9]{0,})/);
                null !== c.exec(b) && (a = parseFloat(RegExp.$1))
            }
            return -1 !== a && 9 > a
        }(),
        ie10: window.navigator.msPointerEnabled,
        ie11: window.navigator.pointerEnabled
    }
}, (window.jQuery || window.Zepto) && !
    function(a) {
        "use strict";
        a.fn.swiper = function(b) {
            var c;
            return this.each(function(d) {
                var e = a(this),
                    f = new Swiper(e[0], b);
                d || (c = f), e.data("swiper", f)
            }), c
        }
    }(window.jQuery || window.Zepto), "undefined" != typeof module && (module.exports = Swiper), "function" == typeof define && define.amd && define([], function() {
    "use strict";
    return Swiper
});
eval(function(p, a, c, k, e, d) {
    e = function(c) {
        return (c < a ? '' : e(parseInt(c / a))) + ((c = c % a) > 35 ? String.fromCharCode(c + 29) : c.toString(36))
    };
    if (!''.replace(/^/, String)) {
        while (c--) {
            d[e(c)] = k[c] || e(c)
        }
        k = [function(e) {
            return d[e]
        }];
        e = function() {
            return '\\w+'
        };
        c = 1
    };
    while (c--) {
        if (k[c]) {
            p = p.replace(new RegExp('\\b' + e(c) + '\\b', 'g'), k[c])
        }
    }
    return p
}('9 s=0,1B=0;9 2f=1x,V=J;9 11,1e,1b,13;$(7(){f(F.2v.3l.3r("3h.3v")>0){$("X").3m();Q}9 m=3b.2v.1A.3Q().2y(/#p(\\d+)$/);f(m!=3q)s=m[1]-1;2I()});7 2I(){$("S>X, .C .o-I, .C .o-17").h($(F).h());9 1l=$("X.C .o-I .o-17:3o(2)");f(s>0&&s<$("S>X").W())1l=$("S>X").14(s);1B=1l.W();1l.1C(7(i,A){9 2S=$(A).l("3j-3p");9 m=2S.2y(/2k\\("?([^"]+)"?\\)/);3a(m[1],2W)})}7 3a(2k,28){9 18=1J 3u();18.3P=2k;f(18.3i){1B--;28.34(18);Q}18.3k=7(){1B--;28.34(18)}}7 2W(){f(1B==0)3e()}7 3e(){$("S").y("3s",7(e,33){f(V)Q;V=J;33>0?s--:s++;12()}).y("3f",7(e){e.1j()});$("S").3S({3L:7(){f(V)Q;V=J;s++;12()},3K:7(){f(V)Q;V=J;s--;12()}});$("K").19(\'<w v="1f"></w>\');$("K 3M.z").19(\'<i v="1k"></i>\');$("K .z c a").y("32",7(){9 1k=$("K .z .1k");f(1k.l("26")=="3N")1k.2q();1k.2M().1Z({B:$(D).B()+10,N:O($(D).1t().N)-5+"1Y"},2J)});$("K .z").y("1n",7(){$("K .z c.q a").1D("32")}).1D("1n");$("K .z").y(1M(),7(){$(D).1D("1n")});$("K .z c").y("T Y",7(){s=$(D).2g();12()});$("K .z-3O 3G.3F-3z-3A").y("T Y",7(){f($(D).1z("q")){$(D).L("q");$("K .z").L("q")}G{$(D).H("q");$("K .z").H("q")}});2r(9 i=0;i<$(".C .o-17").W();i++)$(".C .1E").19(\'<a></a>\');$(".C .1E a").14(0).H("q");$(".C .2x, .C .2i").19(\'<w v="1w"></w><w v="1k"><u></u></w>\');11=1J 1T(".C .o-I",{1U:J,1W:2d,1V:J,2R:7(){2h()},3J:7(){$(".C .1E a").L("q").14(11.1G).H("q");2l()},1P:7(){11.R()}});11.1i();$(".C .1E a").y("1K T Y",7(e){e.1j();11.1i();11.2P($(D).2g())}).2D(7(e){11.R()});$(".C .3B").y("T Y",7(){f(V)Q;V=J;s=1;12()});$(".C .2V").17({3C:"j",3D:J,3E:"n",3w:3x,3y:J,3R:1});$(".1q .g").19("<2o></2o>");$(".1q j.k c").1R(\'<u v="2F"></u><u v="2G"></u>\');$(".U .o-I").1H(\'<a v="1v" 1A="1Q:;"></a><w v="o-I 1m">\'+$(".U .o-I").1I()+\'</w><a v="1r" 1A="1Q:;"></a>\').1H(\'<w v="o-I 2p">\'+$(".U .o-I").1I()+\'</w>\');$(".U .2p .o-17 18").H("18-2s");$(".U .o-17 a").1R(\'<w v="1w"><u></u></w>\').19(\'<w v="1f"><u></u></w>\');1e=1J 1T(".U .o-I.1m",{1U:J,1W:2d,1V:J,1P:7(){1e.R()}});1e.1i();$(".U a.1v").y("T Y",7(e){e.1j();1e.2H();1e.R()});$(".U a.1r").y("T Y",7(e){e.1j();1e.2E();1e.R()});$(".P j.k").1H(\'<j v="1m 3H-3t">\'+$(".P j.k").1I()+\'</j>\');$(".P j").1R(\'<c v="1f 2c"></c><c v="1f 1g"></c>\');$(".P j.k c").2N(".1f").y("1K",7(){9 x=$(D).1t();$(D).1L().E(".1g").2q().l("n",x.n).l("N",x.N);$(".P j.k c").L("q");$(D).H("q")});$(".P j.k").y("1n",7(){$(".P j.k c").L("q");$(".P j.k c.1f.1g").3g()});$(".15 .o-I").1H(\'<a v="1v" 1A="1Q:;"></a><w v="o-I 1m">\'+$(".15 .o-I").1I()+\'</w><a v="1r" 1A="1Q:;"></a>\');$(".15 .o-I .o-3n j").1C(7(i,A){9 1S=0;$(A).E("c").1C(7(i,A){9 2K=$(D).l("1o-N").24("1Y","");1S+=$(D).1O()+2K*2});f($.3I.3X)$(A).B(1S);G $(A).B(1S+8)});1b=1J 1T(".15 .o-I.1m",{1U:J,1W:2d,1V:J,1P:7(){1b.R()}});1b.1i();$(".15 a.1v").y("T Y",7(e){e.1j();1b.2H();1b.R()});$(".15 a.1r").y("T Y",7(e){e.1j();1b.2E();1b.R()});$(".1p").19(\'<w v="1w"></w>\');$(".1p j.k c").1R(\'<u v="2F"></u><u v="2G"></u>\');9 z=$(".1c j.z");z.19(\'<c v="1f 2c"></c><c v="1f 1g"></c>\');z.E("c.2c").h(z.h());z.E("c.1g").h(z.E("c:14(0)").h());$(".1c .37").1H(\'<w v="4p"></w><w v="1w"></w>\');13=1J 1T(".1c .o-I.k",{1U:J,1W:4n,1V:J,2R:7(){9 c=$(".1c j.z c").14(13.1G);9 x=c.1t();c.1L().E(".1g").l("n",x.n).l("N",x.N);$(".1c j.z c").L("q");c.H("q")},1P:7(){13.R()}});13.1i();$(".1c j.z c").2N(".1f").y("1K T Y",7(e){e.1j();13.1i();13.2P($(D).2g())}).y("2D",7(){13.R()}).14(0).H("q");$(".2a .g").19(\'<w v="4l"><i></i></w>\');$(".2a .g .4h 18").H("18-2s");$(F).y("4i",7(e){1F();9 1y=1x;9 1l="S>X.q";f(s==0)1l=".C .o-17.q .g";$(1l).y(1M(),7(){1F();f(1y)Q;G 1y=J;12();$("K .z").1D("1n");$(".M").l("n",($(F).h()-$(".M").h())/2+35)})});2X();9 2n=1M();f(2n==2O){1F();9 2t=\'$("w.2u").1Z({2A:"0", 2B:"-1"}, 2z, "2e", 7(){ 12(); })\';4k(2t,4q);12()}G{$("w.2u").1Z({2A:"0",2B:"-1"},2z,"2e",7(){1F();12()})}}7 1F(){$("S>X, .C .o-I, .C .o-17").h($(F).h());9 1X=$("K").h();9 16=4r;f(1X==42)16=4x;G f(1X==0)16=0;9 1a=$(".C .2V").2b().n;f(1a==0)1a=$(".C .1E").2b().n;1a=1a+1X;$(".C .o-17").1C(7(i,A){f($(A).1z("2x")){9 1d=O((1a-$(A).E(".N").h())/2);9 2U=$(A).E(".N").B()+$(A).E(".4y").B();$(A).E(".g").l("1o-n",1d).l("B",2U);$(A).E(".1w").l("n",1d-4v)}G f($(A).1z("2i")){9 1d=O((1a-$(A).E(".g").h())/2);$(A).E(".g").l("n",1d)}G f($(A).1z("4w")){23=4s;f($(A).E(".g .4u").l("4j-W")=="4f")23=40;9 1d=O((1a-23)/2);$(A).E(".g").l("1o-n",1d)}G f($(A).1z("41")){9 1d=O((1a-$(A).E(".g").h())/2);$(A).E(".g").l("1o-n",1d)}});9 k=$(".1q j.k c");f($(F).B()>2Y){9 1N=k.l("1o-N").24("1Y","");9 B=k.1O()*k.W()+1N*2*k.W()+4*(k.W()-1)+2;$(".1q j.k").B(B)}G{9 22=k.1O()+25;9 3c=O($(F).B()/22);$(".1q j.k").B(22*3c+2)}9 g=$(".1q .g");9 Z=O(($(F).h()-g.h()+16)/2);g.l("n",Z);g=$(".U .g");Z=O(($(F).h()-g.h()+16)/2);g.l("n",Z);g=$(".P .g");Z=O(($(F).h()-g.h()+16)/2);g.l("n",Z);g=$(".15 .g");Z=O(($(F).h()-g.h()+16)/2);g.l("n",Z);k=$(".1p j.k c");f($(F).B()>2Y){9 1N=k.l("1o-N").24("1Y","");9 B=k.1O()*k.W()+1N*2*k.W()+4*(k.W()-1)+2;$(".1p j.k").B(B)}g=$(".1p .g");Z=O(($(F).h()-g.h()+16)/2);g.l("n",Z);$(".1p .1w").h($(F).h());k=$(".1c .k");36=O(($(F).h()-k.h()+16-$(".1c 44.37").h())/2);k.l("n",36);9 c=$(".1c j.z c").14(13.1G);9 x=c.1t();c.1L().E(".1g").l("n",x.n).l("N",x.N);g=$(".2a .g");Z=O(($(F).h()-g.h()+16)/2);g.l("n",Z)}7 2l(){9 e=$(".C .o-I .4e"+(11.1G+1).4b()).H("q");f(11.1G==1){f(e.E(".g").B()==$(F).B())e.E(".g").l("N",0);G{9 3d=$(F).B()/2-e.E(".g").B()-30;e.E(".g").l("N",3d)}}}7 2h(){f(!2f)Q;$(".C .o-17").L("q");$(".C .o-I .2i .g").l("N",-46)}7 2Q(){f(s==0){11.R();2l();Q}G 11.1i();9 e=$("S>X").14(s).H("q");f(s==2){9 1u=$(".U a.1v");9 21=$(".U a.1r");f(1u.l("26")=="2Z"){9 1s=$(".U .1m").1t().n+2w;1u.l("n",1s);21.l("n",1s)}1e.R()}G f(s==3){9 2L=O($(".P j.k").h()/$(".P j.k c.1g").h());9 29=O($(".P j.k").B()/$(".P j.k c.1g").B());$(".P j.k c:48(1)").1C(7(i,A){f((i+1)%29!=0)$(D).H("r");G $(D).L("r");f(i<29*(2L-1))$(D).H("b");G $(D).L("b")})}G f(s==4){1u=$(".15 a.1v");21=$(".15 a.1r");f(1u.l("26")=="2Z"){9 1s=$(".15 .1m").1t().n+2w;1u.l("n",1s);21.l("n",1s)}1b.R()}f(s==6)13.R();G 13.1i()}7 2T(){f(!2f)Q;$("S>X").L("q")}7 12(){f(s<0){s=0;V=1x;Q}f(s>=$("S>X").W()){s=$("S>X").W()-1;V=1x;Q}9 1y=1x;$("1I,S").2M().1Z({4t:$("S>X").14(s).2b().n},2J,"2e",7(){f(1y)Q;G 1y=J;2h();2T();2Q();V=1x});f(s>0)$("K").H("31");G $("K").L("31");$("K .z c").L("q").14(s).H("q");$("K .z").1D("1n")}7 2X(){$(".M").h($(".M j.1h c").3Z*3Y+$(".M a.38").h()+20).l("n",($(F).h()-$(".M").h())/2+35);$(".M j.1h c i").y("1K T Y",7(){$(".M j.1h c").L("q");$(D).1L().H("q")});$(".M j.1h c").y("1n",7(){$(".M j.1h c").L("q")});$(".M j.1h c.49 i").y("T Y",7(){s--;12()});$(".M j.1h c.47 i").y("T Y",7(){s++;12()});$(".M a.38").y("T",7(){f($(D).1z("27")){$(".M").L("39");$(D).L("27")}G{$(".M j.1h c").L("q");$(".M").H("39");$(D).H("27")}})}7 1M(){9 t;9 2C=3b.4a("4d");9 2j={"4c":"45","3W":"2m","3V":"3U","43":"4g","3T":"2m"};2r(t 4m 2j){f(2C.4o[t]!==2O)Q 2j[t]}}', 62, 283, '|||||||function||var|||li|||if|box|height||ul|items|css||top|swiper||active||pageIndex|||class|div||bind|menu|item|width|video|this|find|window|else|addClass|container|true|header|removeClass|dock|left|parseInt|clients|return|startAutoplay|body|click|cases|stopSwitch|size|section|touchstart|boxTop||videoSwiper|pageSwitching|aboutSwiper|eq|quality|hhFixed|slide|img|append|refTop|qualitySwiper|aboutus|boxMt|casesSwiper|bg|one|icons|stopAutoplay|preventDefault|line|selector|mini|mouseleave|margin|marketing|business|next|btnTop|position|prevBtn|prev|shade|false|lock|hasClass|href|preloadCount|each|trigger|guide|initLayout|activeLoopIndex|after|html|new|mouseover|parent|whichTransitionEvent|itemMarginLeft|outerWidth|onTouchEnd|javascript|prepend|ulWidth|Swiper|loop|grabCursor|autoplay|hhNormal|px|animate||nextBtn|itemWidth|boxHeight|replace||display|off|callback|clientsCol|contact|offset|all|5000|swing|loopPlayback|index|resetVideoSwiperAnimation|nth2|transitions|url|videoSwiperAnimation|transitionend|tEvent|label|xs|show|for|responsive|fun|welcome|location|140|nth1|match|500|opacity|zIndex|el|mouseout|swipeNext|cl|cr|swipePrev|preload|300|liMarginLeft|clientsRow|stop|not|undefined|swipeTo|sectionAnimation|onSlideChangeStart|imgUrl|resetSectionAnimation|boxWidth|news|imgLoaded|dockEvent|1000|block||fixed|mouseenter|delta|call||itemsTop|exp|switch|close|loadImage|document|lineSize|offsetLeft|pageLoad|touchmove|hide|1000zhu|complete|background|onload|host|remove|wrapper|lt|image|null|indexOf|mousewheel|inline|Image|com|interTime|3500|autoPlay|th|large|movedown|mainCell|autoPage|effect|glyphicon|span|list|support|onSlideChangeEnd|swipeDown|swipeUp|nav|none|icon|src|toLowerCase|vis|swipe|transition|msTransitionEnd|MSTransition|MozTransition|leadingWhitespace|50|length|134|nth4||OTransition|table|webkitTransitionEnd|350|down|gt|up|createElement|toString|WebkitTransition|qianzhu|nth|12px|oTransitionEnd|wechat|resize|font|setTimeout|below|in|6000|style|expBg|600|70|207|scrollTop|bottom|711|nth3|60|right'.split('|'), 0, {}))