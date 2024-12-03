@component
export class CounterRotatorUtility extends BaseScriptComponent {
    @input
    @hint("Object to counter-rotate")
    pointerObject: SceneObject | undefined;
    
    @input
    @hint("Camera reference")
    cameraObject: SceneObject | undefined;
    
    onUpdate(): void {
        if (!this.pointerObject || !this.cameraObject) {
            return;
        }
        
        // Get camera's Y rotation in world space
        const cameraRotationY = this.cameraObject.getTransform().getWorldRotation().toEulerAngles().y;
        
        // Counter-rotate the object locally by the negative amount
        this.pointerObject.getTransform().setLocalRotation(quat.fromEulerAngles(0, -cameraRotationY, 0));
    }
}