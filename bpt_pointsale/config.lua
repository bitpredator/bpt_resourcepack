Config = {}

-- Pawn Shop Positions:
Config.PawnZones = {
	PointSales = {
		Pos = {
			{x = -429.046143,  y = -1729.199951, z = 19.776611},
		}
	}
}

-- Pawn Shop Blip Settings:
Config.EnablePointSaleBlip = true
Config.BlipName = "Punto Vendita"

-- Pawn Shop Marker Settings:
Config.KeyToOpenShop = 38														-- default 38 is E
Config.ShopMarker = 27 															-- marker type
Config.ShopMarkerColor = { r = 255, g = 255, b = 0, a = 100 } 					-- rgba color of the marker
Config.ShopMarkerScale = { x = 1.0, y = 1.0, z = 1.0 }  						-- the scale for the marker on the x, y and z axis
Config.ShopDraw3DText = "Premi ~g~[E]~s~ per ~y~vendere~s~"					-- set your desired text here

-- Pawn Shop Item List:
Config.ItemsInPointSale = {
	{ itemName = 'garbage', label = 'rifiuti', BuyInPointSale = false, BuyPrice = 1, SellInPointSale = true, SellPrice = 1 },
    { itemName = 'legnatagliata', label = 'legna tagliata', BuyInPointSale = false, BuyPrice = 1, SellInPointSale = true, SellPrice = 1 },
}
