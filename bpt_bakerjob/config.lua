Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).

Config.EnablePlayerManagement     = true -- Enable society managing.
Config.EnableSocietyOwnedVehicles = false

Config.Locale                     = 'it'

Config.OxInventory                = ESX.GetConfig().OxInventory

Config.AuthorizedVehicles = {
	{model = 'rumpo', label = 'Rumpo'}
}

Config.Zones = {

	VehicleSpawner = {
		Pos   = {x = 2335.476807, y = 3132.184570, z = 48.185303}, 
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 145, g = 30, b = 30},
		Type  = 36, Rotate = true
	},

	VehicleSpawnPoint = {
		Pos     = {x = 2330.386719, y = 3138.646240, z = 48.151611},
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Type    = -1, Rotate = false,
		Heading = 225.0
	},

	VehicleDeleter = {
		Pos   = {x = 2330.386719, y = 3138.646240, z = 47.151611},
		Size  = {x = 3.0, y = 3.0, z = 0.25},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1, Rotate = false
	},

	BakerActions = {
		Pos   = {x = 2340.633057, y = 3126.514404, z = 48.202148},
		Size  = {x = 0.5, y = 0.5, z = 0.5},
		Color = {r = 204, g = 204, b = 0},
		Type  = 20, Rotate = true
	},

	Cloakroom = {
		Pos     = {x = 2348.017578, y = 3122.083496, z = 48.202148},
		Size    = {x = 0.5, y = 0.5, z = 0.5},
		Color   = {r = 204, g = 204, b = 0},
		Type    = 21, Rotate = true
	}
}
