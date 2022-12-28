Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).

Config.MaxInService               = -1 -- How much people can be in service at once?
Config.EnablePlayerManagement     = true -- Enable society managing.
Config.EnableSocietyOwnedVehicles = false

Config.Locale                     = 'it'

Config.OxInventory                = ESX.GetConfig().OxInventory

Config.AuthorizedVehicles = {
	{model = 'biff', label = 'Camion'}
}

Config.Zones = {

	VehicleSpawner = {
		Pos   = {x = - 440.531860, y = -1696.087891, z = 18.934082},
		Size  = {x = 0.6, y = 0.6, z = 0.6},
		Color = {r = 204, g = 204, b = 0},
		Type  = 36, Rotate = true
	},

	VehicleSpawnPoint = {
		Pos     = {x = -434.004395, y = -1707.006592, z = 18.967773},
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Type    = -1, Rotate = false,
		Heading = 225.0
	},

	VehicleDeleter = {
		Pos   = {x = -434.004395, y = -1707.006592, z = 17.967773},
		Size  = {x = 3.0, y = 3.0, z = 0.25},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1, Rotate = false
	},

	DustmanActions = {
		Pos   = {x = -420.342865, y = -1675.054932, z = 19.018311}, 
		Size  = {x = 0.6, y = 0.6, z = 0.6},
		Color = {r = 204, g = 204, b = 0},
		Type  = 20, Rotate = true
	},

	Cloakroom = {
		Pos     = {x = -430.760437, y = -1672.958252, z = 19.018311}, 
		Size    = {x = 0.6, y = 0.6, z = 0.6},
		Color   = {r = 204, g = 204, b = 0},
		Type    = 21, Rotate = true
	}
}
