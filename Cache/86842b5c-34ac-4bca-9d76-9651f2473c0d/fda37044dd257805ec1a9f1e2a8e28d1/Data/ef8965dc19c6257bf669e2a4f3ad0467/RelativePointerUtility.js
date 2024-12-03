"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.CounterRotatorUtility = void 0;
var __selfType = requireType("./CounterRotatorUtility");
function component(target) { target.getTypeName = function () { return __selfType; }; }
let CounterRotatorUtility = class CounterRotatorUtility extends BaseScriptComponent {
    onUpdate() {
        if (!this.pointerObject || !this.cameraObject) {
            return;
        }
        // Get camera's Y rotation in world space
        const cameraRotationY = this.cameraObject.getTransform().getWorldRotation().toEulerAngles().y;
        // Counter-rotate the object locally by the negative amount
        this.pointerObject.getTransform().setLocalRotation(quat.fromEulerAngles(0, -cameraRotationY, 0));
    }
};
exports.CounterRotatorUtility = CounterRotatorUtility;
exports.CounterRotatorUtility = CounterRotatorUtility = __decorate([
    component
], CounterRotatorUtility);
//# sourceMappingURL=CounterRotatorUtility.js.map