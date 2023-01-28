Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MaxInService               = -1 -- How much people can be in service at once?
Config.EnablePlayerManagement     = true -- Enable society managing.
Config.EnableSocietyOwnedVehicles = false
Config.Locale                     = 'it'
Config.OxInventory                = ESX.GetConfig().OxInventory

Config.AuthorizedVehicles = {
	{model = 'rentalbus', label = 'rentalbus'}
}

Config.Zones = {

	VehicleSpawner = {
		Pos   = {x = 137.177, y = -1278.757, z = 29.371},  
		Size  = {x = 0.6, y = 0.6, z = 0.6},
		Color = {r = 204, g = 204, b = 0},
		Type  = 36, Rotate = true
	},

	VehicleSpawnPoint = {
		Pos     = {x = 139.780228, y = -1270.945068, z = 29.094482},
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Type    = -1, Rotate = false,
		Heading = 225.0
	},

	VehicleDeleter = {
		Pos   = {x = 133.203, y = -1265.573, z = 28.396},
		Size  = {x = 3.0, y = 3.0, z = 0.25},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1, Rotate = false
	},

	UnicornActions = {
		Pos   = {x = 94.951, y = -1294.021, z = 29.268},
		Size  = {x = 0.6, y = 0.6, z = 0.6},
		Color = {r = 204, g = 204, b = 0},
		Type  = 20, Rotate = true
	},

	Cloakroom = {
		Pos     = {x = 105.362640, y = -1303.081299, z = 28.757568},
		Size    = {x = 0.6, y = 0.6, z = 0.6},
		Color   = {r = 204, g = 204, b = 0},
		Type    = 21, Rotate = true
	}
}
