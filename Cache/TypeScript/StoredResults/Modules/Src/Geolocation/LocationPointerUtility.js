"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ObjectTrackerUtility = void 0;
var __selfType = requireType("./LocationPointerUtility");
function component(target) { target.getTypeName = function () { return __selfType; }; }
let ObjectTrackerUtility = class ObjectTrackerUtility extends BaseScriptComponent {
    onStart() {
        if (!this.pointerObject) {
            print("Error: Pointer object not assigned");
            return;
        }
        // Create empty object in front of camera
        this.targetObject = global.scene.createSceneObject("Target");
        const targetTransform = this.targetObject.getTransform();
        // Position it 5 units in front of where we start
        targetTransform.setLocalPosition(new vec3(0, 0, 5));
    }
    onUpdate() {
        if (!this.pointerObject || !this.targetObject) {
            return;
        }
        // Get positions
        const pointerPos = this.pointerObject.getTransform().getWorldPosition();
        const targetPos = this.targetObject.getTransform().getWorldPosition();
        // Calculate direction to target
        const direction = targetPos.sub(pointerPos);
        // Calculate angle in the XZ plane (Y-axis rotation)
        const angle = Math.atan2(direction.x, direction.z);
        // Create rotation only around Y axis
        const rotation = quat.fromEulerAngles(0, angle * (180 / Math.PI), 0);
        // Apply rotation
        this.pointerObject.getTransform().setLocalRotation(rotation);
    }
    __initialize() {
        super.__initialize();
        this.targetObject = null;
    }
};
exports.ObjectTrackerUtility = ObjectTrackerUtility;
exports.ObjectTrackerUtility = ObjectTrackerUtility = __decorate([
    component
], ObjectTrackerUtility);
//# sourceMappingURL=LocationPointerUtility.js.map