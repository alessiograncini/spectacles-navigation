if (script.onAwake) {
	script.onAwake();
	return;
};
function checkUndefined(property, showIfData){
   for (var i = 0; i < showIfData.length; i++){
       if (showIfData[i][0] && script[showIfData[i][0]] != showIfData[i][1]){
           return;
       }
   }
   if (script[property] == undefined){
      throw new Error('Input ' + property + ' was not provided for the object ' + script.getSceneObject().name);
   }
}
// @input Component.Text geolocationText {"hint":"Assign a Text component to display geolocation data."}
checkUndefined("geolocationText", []);
// @input Component.Text placeText {"hint":"Assign a Text component to display the nearest location name."}
checkUndefined("placeText", []);
// @input Asset.MapModule mapModule {"hint":"Assign the MapModule asset."}
checkUndefined("mapModule", []);
var scriptPrototype = Object.getPrototypeOf(script);
if (!global.BaseScriptComponent){
   function BaseScriptComponent(){}
   global.BaseScriptComponent = BaseScriptComponent;
   global.BaseScriptComponent.prototype = scriptPrototype;
   global.BaseScriptComponent.prototype.__initialize = function(){};
   global.BaseScriptComponent.getTypeName = function(){
       throw new Error("Cannot get type name from the class, not decorated with @component");
   }
}
var Module = require("../../../Modules/Src/Src/Geolocation/GeolocationUtility");
Object.setPrototypeOf(script, Module.GeolocationUtility.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
