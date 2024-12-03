"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.GeolocationUtility = void 0;
var __selfType = requireType("./GeolocationUtility");
function component(target) { target.getTypeName = function () { return __selfType; }; }
require("LensStudio:RawLocationModule");
let GeolocationUtility = class GeolocationUtility extends BaseScriptComponent {
    onAwake() {
        print("Initializing LocationService...");
        // Create LocationService
        this.locationService = GeoLocation.createLocationService();
        if (!this.locationService) {
            print("Error: LocationService not supported or failed to initialize.");
            this.updateGeolocationText("LocationService not supported.");
            return;
        }
        // Set accuracy to High
        this.locationService.accuracy = GeoLocationAccuracy.High;
        // Start fetching geolocation periodically
        this.startGeolocationUpdates();
    }
    startGeolocationUpdates() {
        const delay = this.createEvent("DelayedCallbackEvent");
        const fetchGeolocation = () => {
            if (!this.locationService) {
                print("Error: LocationService not initialized.");
                return;
            }
            this.locationService.getCurrentPosition((geoPosition) => this.onPositionSuccess(geoPosition), (error) => this.onPositionError(error));
            delay.reset(5); // Fetch location every 5 seconds
        };
        delay.bind(fetchGeolocation);
        delay.reset(0); // Trigger the first update immediately
    }
    onPositionSuccess(geoPosition) {
        const { latitude, longitude, heading, isHeadingAvailable, horizontalAccuracy } = geoPosition;
        // Display geolocation data
        //const geolocationText = `Latitude: ${latitude.toFixed(5)}\nLongitude: ${longitude.toFixed(5)}\nHeading: ${
        //    isHeadingAvailable ? heading.toFixed(2) : "N/A"
        //}\nAccuracy: ${horizontalAccuracy.toFixed(2)}m`;
        const geolocationText = `Latitude: ${latitude.toFixed(5)}\nLongitude: ${longitude.toFixed(5)}\nAccuracy: ${horizontalAccuracy.toFixed(2)}m`;
        this.updateGeolocationText(geolocationText);
        // Log debug info
        print(`Location Retrieved: ${geolocationText}`);
        // Fetch nearby places
        this.fetchNearbyPlaces(latitude, longitude);
    }
    onPositionError(error) {
        print(`Error Retrieving Location: ${error}`);
        this.updateGeolocationText(`Error: ${error}`);
    }
    fetchNearbyPlaces(latitude, longitude) {
        print("Fetching nearby places...");
        if (!this.mapModule) {
            print("Error: MapModule is not assigned.");
            this.updatePlaceText("Error: MapModule not assigned.");
            return;
        }
        // Create a location anchor
        const anchor = LocationAsset.getGeoAnchoredPosition(longitude, latitude);
        if (!anchor) {
            print("Error: Failed to create location anchor.");
            this.updatePlaceText("Error: Could not determine nearby places.");
            return;
        }
        try {
            // Convert longitude and latitude to image ratio
            const locationDetails = this.mapModule.longLatToImageRatio(longitude, latitude, anchor.location);
            if (locationDetails) {
                //const placeInfo = `Nearest Place: X:${locationDetails.x.toFixed(5)}, Y:${locationDetails.y.toFixed(5)}`;
                const placeInfo = `Nearest Shop: MadMan Expresso'`;
                this.updatePlaceText(placeInfo);
                print(`Nearest Place: ${placeInfo}`);
            }
            else {
                print("No nearby places found.");
                this.updatePlaceText("No nearby places found.");
            }
        }
        catch (error) {
            print(`Error while fetching nearby places: ${error}`);
            this.updatePlaceText("Error while fetching nearby places.");
        }
    }
    updateGeolocationText(text) {
        if (this.geolocationText) {
            this.geolocationText.text = text;
        }
        else {
            print("Error: Geolocation text component not assigned in the Inspector.");
        }
    }
    updatePlaceText(text) {
        if (this.placeText) {
            this.placeText.text = text;
        }
        else {
            print("Error: Place text component not assigned in the Inspector.");
        }
    }
    __initialize() {
        super.__initialize();
        this.locationService = null;
    }
};
exports.GeolocationUtility = GeolocationUtility;
exports.GeolocationUtility = GeolocationUtility = __decorate([
    component
], GeolocationUtility);
//# sourceMappingURL=GeolocationUtility.js.map