"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.RealDistancePointerUtility = void 0;
var __selfType = requireType("./RealDistancePointerUtility");
function component(target) { target.getTypeName = function () { return __selfType; }; }
require("LensStudio:RawLocationModule");
let RealDistancePointerUtility = class RealDistancePointerUtility extends BaseScriptComponent {
    onAwake() {
        if (!this.pointerObject) {
            print("Error: Pointer object not assigned");
            return;
        }
        // Create target at actual distance
        this.targetObject = global.scene.createSceneObject("MadmanTarget");
        const transform = this.targetObject.getTransform();
        // Position it at the real distance along Z
        transform.setLocalPosition(new vec3(0, 0, this.REAL_DISTANCE_METERS));
        print("Target created at distance: " + this.REAL_DISTANCE_METERS);
    }
    onUpdate() {
        if (!this.pointerObject || !this.targetObject) {
            return;
        }
        // Get positions
        const pointerPos = this.pointerObject.getTransform().getWorldPosition();
        const targetPos = this.targetObject.getTransform().getWorldPosition();
        // Calculate direction
        const direction = targetPos.sub(pointerPos);
        const angle = Math.atan2(direction.x, direction.z);
        // Apply rotation
        this.pointerObject.getTransform().setLocalRotation(quat.fromEulerAngles(0, angle * (180 / Math.PI), 0));
    }
    __initialize() {
        super.__initialize();
        this.targetObject = null;
        this.REAL_DISTANCE_METERS = 1287.48;
    }
};
exports.RealDistancePointerUtility = RealDistancePointerUtility;
exports.RealDistancePointerUtility = RealDistancePointerUtility = __decorate([
    component
], RealDistancePointerUtility);
//# sourceMappingURL=RealDistancePointerUtility.js.map