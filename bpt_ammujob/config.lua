Config                            = {}
Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MaxInService               = -1 -- How much people can be in service at once?
Config.EnablePlayerManagement     = true -- Enable society managing.
Config.EnableSocietyOwnedVehicles = false
Config.Locale                     = 'en'

Config.AuthorizedVehicles = {
	{model = 'rumpo', label = 'Rumpo'}
}

Config.Zones = {

	VehicleSpawner = {
		Pos   = {x = 821.340637, y = -2146.417480, z = 28.706909},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 145, g = 30, b = 30},
		Type  = 36, Rotate = true
	},

	VehicleSpawnPoint = {
		Pos     = {x = 822.540649, y = -2134.575928, z = 29.279907},
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Type    = -1, Rotate = false,
		Heading = 225.0
	},

	VehicleDeleter = {
		Pos   = {x = 822.540649, y = -2134.575928, z = 28.279907},
		Size  = {x = 3.0, y = 3.0, z = 0.25},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1, Rotate = false
	},

	AmmuActions = {
		Pos   = {x = 812.479126, y = -2159.182373, z = 29.616821},
		Size  = {x = 0.5, y = 0.5, z = 0.5},
		Color = {r = 204, g = 204, b = 0},
		Type  = 20, Rotate = true
	},

	Cloakroom = {
		Pos     = {x = 810.065918, y = -2162.439453, z = 29.616821},
		Size    = {x = 0.5, y = 0.5, z = 0.5},
		Color   = {r = 204, g = 204, b = 0},
		Type    = 21, Rotate = true
	}
}