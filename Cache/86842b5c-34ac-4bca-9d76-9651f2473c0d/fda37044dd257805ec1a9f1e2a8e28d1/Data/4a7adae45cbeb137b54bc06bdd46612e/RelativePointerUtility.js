"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.RelativePointerUtility = void 0;
var __selfType = requireType("./RelativePointerUtility");
function component(target) { target.getTypeName = function () { return __selfType; }; }
require("LensStudio:RawLocationModule");
let RelativePointerUtility = class RelativePointerUtility extends BaseScriptComponent {
    onAwake() {
        if (!this.pointerObject || !this.cameraObject) {
            print("Error: Required objects not assigned");
            return;
        }
        // Store initial rotations
        this.initialCameraRotation = this.cameraObject.getTransform().getWorldRotation();
        this.initialObjectRotation = this.pointerObject.getTransform().getWorldRotation();
        print("Initial rotations captured");
    }
    onUpdate() {
        if (!this.pointerObject || !this.cameraObject || !this.initialCameraRotation || !this.initialObjectRotation) {
            return;
        }
        // Get current camera rotation
        const currentCameraRotation = this.cameraObject.getTransform().getWorldRotation();
        // Calculate the rotation difference from start
        const rotationDiff = currentCameraRotation.multiply(this.initialCameraRotation.invert());
        // Apply the difference to maintain the initial relative direction
        this.pointerObject.getTransform().setWorldRotation(rotationDiff.multiply(this.initialObjectRotation));
    }
    __initialize() {
        super.__initialize();
        this.initialCameraRotation = null;
        this.initialObjectRotation = null;
    }
};
exports.RelativePointerUtility = RelativePointerUtility;
exports.RelativePointerUtility = RelativePointerUtility = __decorate([
    component
], RelativePointerUtility);
//# sourceMappingURL=RelativePointerUtility.js.map