Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).

Config.MaxInService               = -1 -- How much people can be in service at once?
Config.EnablePlayerManagement     = true -- Enable society managing.
Config.EnableSocietyOwnedVehicles = false

Config.Locale                     = 'it'

Config.OxInventory                = ESX.GetConfig().OxInventory

Config.AuthorizedVehicles = {
	{model = 'rumpo', label = 'Rumpo'}
}

Config.Zones = {

	VehicleSpawner = {
		Pos   = {x = 1021.912109, y = -2372.043945, z = 30.526733},  
		Size  = {x = 0.6, y = 0.6, z = 0.6},
		Color = {r = 204, g = 204, b = 0},
		Type  = 36, Rotate = true
	},

	VehicleSpawnPoint = {
		Pos     = {x = 1015.740662, y = -2366.624268, z = 30.493042},
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Type    = -1, Rotate = false,
		Heading = 225.0
	},

	VehicleDeleter = {
		Pos   = {x = 1015.740662, y = -2366.624268, z = 29.493042},
		Size  = {x = 3.0, y = 3.0, z = 0.25},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1, Rotate = false
	},

	ImportActions = {
		Pos   = {x = 1006.799988, y = -2404.127441, z = 30.122314},
		Size  = {x = 0.6, y = 0.6, z = 0.6},
		Color = {r = 204, g = 204, b = 0},
		Type  = 20, Rotate = true
	},

	Cloakroom = {
		Pos     = {x = 1011.837341, y = -2390.004395, z = 30.122314},
		Size    = {x = 0.6, y = 0.6, z = 0.6},
		Color   = {r = 204, g = 204, b = 0},
		Type    = 21, Rotate = true
	}
}
