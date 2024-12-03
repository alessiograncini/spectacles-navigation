
require("LensStudio:RawLocationModule");

@component
export class GeolocationUtility extends BaseScriptComponent {
    @input
    @hint("Assign a Text component to display geolocation data.")
    geolocationText: Text | undefined;

    @input
    @hint("Assign a Text component to display the nearest location name.")
    placeText: Text | undefined;

    @input
    @hint("Assign the MapModule asset.")
    mapModule: MapModule | undefined;

    locationService: LocationService | null = null;

    onAwake(): void {
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

    private startGeolocationUpdates(): void {
        const delay = this.createEvent("DelayedCallbackEvent");

        const fetchGeolocation = () => {
            if (!this.locationService) {
                print("Error: LocationService not initialized.");
                return;
            }

            this.locationService.getCurrentPosition(
                (geoPosition: GeoPosition) => this.onPositionSuccess(geoPosition),
                (error: string) => this.onPositionError(error)
            );

            delay.reset(5); // Fetch location every 5 seconds
        };

        delay.bind(fetchGeolocation);
        delay.reset(0); // Trigger the first update immediately
    }

    onPositionSuccess(geoPosition: GeoPosition): void {
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

    onPositionError(error: string): void {
        print(`Error Retrieving Location: ${error}`);
        this.updateGeolocationText(`Error: ${error}`);
    }

    fetchNearbyPlaces(latitude: number, longitude: number): void {
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
                const placeInfo = `Nearest Shop: MadMan Expresso`;
                this.updatePlaceText(placeInfo);
                print(`Nearest Place: ${placeInfo}`);
            } else {
                print("No nearby places found.");
                this.updatePlaceText("No nearby places found.");
            }
        } catch (error) {
            print(`Error while fetching nearby places: ${error}`);
            this.updatePlaceText("Error while fetching nearby places.");
        }
    }

    private updateGeolocationText(text: string): void {
        if (this.geolocationText) {
            this.geolocationText.text = text;
        } else {
            print("Error: Geolocation text component not assigned in the Inspector.");
        }
    }

    private updatePlaceText(text: string): void {
        if (this.placeText) {
            this.placeText.text = text;
        } else {
            print("Error: Place text component not assigned in the Inspector.");
        }
    }
}


