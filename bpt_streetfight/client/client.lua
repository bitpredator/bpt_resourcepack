ESX = nil
local betAmount = 0
local fightStatus = STATUS_INITIAL
local STATUS_INITIAL = 0
local STATUS_JOINED = 1
local STATUS_STARTED = 2
local blueJoined = false
local redJoined = false
local players = 0
local showCountDown = false
local participating = false
local rival = nil
local Gloves = {}
local showWinner = false
local winner = nil

Citizen.CreateThread(function()
    while ESX == nil do
        ESX = exports["es_extended"]:getSharedObject()
        Citizen.Wait(0)
    end
    CreateBlip(Config.BLIP.coords, Config.BLIP.text, Config.BLIP.sprite, Config.BLIP.color, Config.BLIP.scale)
    RunThread()
end)

RegisterNetEvent('bpt_streetfight:playerJoined')
AddEventHandler('bpt_streetfight:playerJoined', function(side, id)

        if side == 1 then
            blueJoined = true
        else
            redJoined = true
        end

        if id == GetPlayerServerId(PlayerId()) then
            participating = true
            putGloves()
        end
        players = players + 1
        fightStatus = STATUS_JOINED

end)

RegisterNetEvent('bpt_streetfight:startFight')
AddEventHandler('bpt_streetfight:startFight', function(fightData)

    for index,value in ipairs(fightData) do
        if(value.id ~= GetPlayerServerId(PlayerId())) then
            rival = value.id      
        elseif value.id == GetPlayerServerId(PlayerId()) then
            participating = true
        end
    end

    fightStatus = STATUS_STARTED
    showCountDown = true
    countdown()

end)

RegisterNetEvent('bpt_streetfight:playerLeaveFight')
AddEventHandler('bpt_streetfight:playerLeaveFight', function(id)

    if id == GetPlayerServerId(PlayerId()) then
        ESX.ShowNotification('Ti sei allontanato troppo, hai rinunciato a combattere')
        SetPedMaxHealth(PlayerPedId(), 200)
        SetEntityHealth(PlayerPedId(), 200)
        removeGloves()
    elseif participating == true then
        TriggerServerEvent('bpt_streetfight:pay', betAmount)
        ESX.ShowNotification('Hai vinto ~r~' .. (betAmount * 2) .. '$')
        SetPedMaxHealth(PlayerPedId(), 200)
        SetEntityHealth(PlayerPedId(), 200)
        removeGloves()
    end
    reset()

end)

RegisterNetEvent('bpt_streetfight:fightFinished')
AddEventHandler('bpt_streetfight:fightFinished', function(looser)

    if participating == true then
        if(looser ~= GetPlayerServerId(PlayerId()) and looser ~= -2) then
            TriggerServerEvent('bpt_streetfight:pay', betAmount)
            ESX.ShowNotification('Hai vinto ~r~' .. (betAmount * 2) .. '$')
            SetPedMaxHealth(PlayerPedId(), 200)
            SetEntityHealth(PlayerPedId(), 200)
    
            TriggerServerEvent('bpt_streetfight:showWinner', GetPlayerServerId(PlayerId()))
        end
    
        if(looser == GetPlayerServerId(PlayerId()) and looser ~= -2) then
            ESX.ShowNotification('hai perso la battaglia ~r~-' .. betAmount .. '$')
            SetPedMaxHealth(PlayerPedId(), 200)
            SetEntityHealth(PlayerPedId(), 200)
        end
    
        if looser == -2 then
            ESX.ShowNotification('La lotta è finita per limite di tempo')
            SetPedMaxHealth(PlayerPedId(), 200)
            SetEntityHealth(PlayerPedId(), 200)
        end

        removeGloves()
    end
    reset()
end)

RegisterNetEvent('bpt_streetfight:raiseActualBet')
AddEventHandler('bpt_streetfight:raiseActualBet', function()
    betAmount = betAmount * 2
    if betAmount == 0 then
        betAmount = 2000
    elseif betAmount > 100000 then
        betAmount = 0
    end
end)

RegisterNetEvent('bpt_streetfight:winnerText')
AddEventHandler('bpt_streetfight:winnerText', function(id)
    showWinner = true
    winner = id
    Citizen.Wait(5000)
    showWinner = false
    winner = nil
end)

local actualCount = 0
function countdown()
    for i = 5, 0, -1 do
        actualCount = i
        Citizen.Wait(1000)
    end
    showCountDown = false
    actualCount = 0

    if participating == true then
        SetPedMaxHealth(PlayerPedId(), 500)
        SetEntityHealth(PlayerPedId(), 500)
    end
end

function putGloves()
    local ped = GetPlayerPed(-1)
    local hash = GetHashKey('prop_boxing_glove_01')
    while not HasModelLoaded(hash) do RequestModel(hash); Citizen.Wait(0); end
    local pos = GetEntityCoords(ped)
    local gloveA = CreateObject(hash, pos.x,pos.y,pos.z + 0.50, true,false,false)
    local gloveB = CreateObject(hash, pos.x,pos.y,pos.z + 0.50, true,false,false)
    table.insert(Gloves,gloveA)
    table.insert(Gloves,gloveB)
    SetModelAsNoLongerNeeded(hash)
    FreezeEntityPosition(gloveA,false)
    SetEntityCollision(gloveA,false,true)
    ActivatePhysics(gloveA)
    FreezeEntityPosition(gloveB,false)
    SetEntityCollision(gloveB,false,true)
    ActivatePhysics(gloveB)
    if not ped then ped = GetPlayerPed(-1); end -- gloveA = L, gloveB = R
    AttachEntityToEntity(gloveA, ped, GetPedBoneIndex(ped, 0xEE4F), 0.05, 0.00,  0.04,     00.0, 90.0, -90.0, true, true, false, true, 1, true) -- object is attached to right hand 
    AttachEntityToEntity(gloveB, ped, GetPedBoneIndex(ped, 0xAB22), 0.05, 0.00, -0.04,     00.0, 90.0,  90.0, true, true, false, true, 1, true) -- object is attached to right hand 
end

function removeGloves()
    for k,v in pairs(Gloves) do DeleteObject(v); end
end

function spawnMarker(coords)
    local centerRing = GetDistanceBetweenCoords(coords, vector3(-517.61,-1712.04,20.46), true)
    if centerRing < Config.DISTANCE and fightStatus ~= STATUS_STARTED then
        
        DrawMarker(1, Config.BETZONE.x, Config.BETZONE.y, Config.BETZONE.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 204,204, 0, 100, false, true, 2, false, false, false, false)
        DrawText3D(Config.CENTER.x, Config.CENTER.y, Config.CENTER.z +1.5, 'Giocatori: ~r~' .. players .. '/2 \n ~w~Scommessa: ~r~'.. betAmount ..'$ ', 0.8)

        local blueZone = GetDistanceBetweenCoords(coords, vector3(Config.BLUEZONE.x, Config.BLUEZONE.y, Config.BLUEZONE.z), true)
        local redZone = GetDistanceBetweenCoords(coords, vector3(Config.REDZONE.x, Config.REDZONE.y, Config.REDZONE.z), true)
        local betZone = GetDistanceBetweenCoords(coords, vector3(Config.BETZONE.x, Config.BETZONE.y, Config.BETZONE.z), true)

        if blueJoined == false then
            DrawText3D(Config.BLUEZONE.x, Config.BLUEZONE.y, Config.BLUEZONE.z +1.5, 'unisciti alla lotta [~b~E~w~]', 0.4)
            if blueZone < Config.DISTANCE_INTERACTION then
                ESX.ShowHelpNotification("premi ~INPUT_CONTEXT~ per unirti al lato blu.")
                if IsControlJustReleased(0, Config.E_KEY) and participating == false then
                    TriggerServerEvent('bpt_streetfight:join', betAmount, 0 )
                end
            end
        end

        if redJoined == false then
            DrawText3D(Config.REDZONE.x, Config.REDZONE.y, Config.REDZONE.z +1.5, 'unisciti alla lotta [~r~E~w~]', 0.4)
            if redZone < Config.DISTANCE_INTERACTION then
                ESX.ShowHelpNotification("premi ~INPUT_CONTEXT~ per unirti al lato rosso.")
                if IsControlJustReleased(0, Config.E_KEY) and participating == false then
                    TriggerServerEvent('bpt_streetfight:join', betAmount, 1)
                end
            end
        end

        if betZone < Config.DISTANCE_INTERACTION and fightStatus ~= STATUS_JOINED and fightStatus ~= STATUS_STARTED then
            ESX.ShowHelpNotification("premi ~INPUT_CONTEXT~ per cambiare la scommessa.")
            if IsControlJustReleased(0, Config.E_KEY) then
                TriggerServerEvent('bpt_streetfight:raiseBet', betAmount)
            end
        end

    end
end

function get3DDistance(x1, y1, z1, x2, y2, z2)
    local a = (x1 - x2) * (x1 - x2)
    local b = (y1 - y2) * (y1 - y2)
    local c = (z1 - z2) * (z1 - z2)
    return math.sqrt(a + b + c)
end

function DrawText3D(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)
    AddTextComponentString(text)
    DrawText(_x, _y)
end

function CreateBlip(coords, text, sprite, color, scale)
	local blip = AddBlipForCoord(coords.x, coords.y)
	SetBlipSprite(blip, sprite)
	SetBlipScale(blip, scale)
	SetBlipColour(blip, color)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandSetBlipName(blip)
end

function reset() 
    redJoined = false
    blueJoined = false
    participating = false
    players = 0
    fightStatus = STATUS_INITIAL
end

function RunThread()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local coords = GetEntityCoords(PlayerPedId())
            spawnMarker(coords)
        end
    end)
end

-- Alejar player - 1000 loop
Citizen.CreateThread(function()
    while true do
        if fightStatus == STATUS_STARTED and participating == false and GetEntityCoords(PlayerPedId()) ~= rival then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            if get3DDistance(Config.CENTER.x, Config.CENTER.y, Config.CENTER.z,coords.x,coords.y,coords.z) < Config.TP_DISTANCE then
                ESX.ShowNotification('Aléjate del ring!')
                for height = 1, 1000 do
                    SetPedCoordsKeepVehicle(GetPlayerPed(-1), -521.58, -1723.58, 19.16)
                    local foundGround, zPos = GetGroundZFor_3dCoord(-521.58, -1723.58, 19.16)
                    if foundGround then
                        SetPedCoordsKeepVehicle(GetPlayerPed(id), -521.58, -1723.58, 19.16)
                        break
                    end
                    Citizen.Wait(5)
                end
            end
        end
        Citizen.Wait(1000)
	end
end)

-- Main 0 loop
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if showCountDown == true then
            DrawText3D(Config.CENTER.x, Config.CENTER.y, Config.CENTER.z + 1.5, 'La lotta inizia in: ' .. actualCount, 2.0)
        elseif showCountDown == false and fightStatus == STATUS_STARTED then
            if GetEntityHealth(PlayerPedId()) < 150 then
                TriggerServerEvent('bpt_streetfight:finishFight', GetPlayerServerId(PlayerId()))
                fightStatus = STATUS_INITIAL
            end
        end
       
        if participating == true then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            if get3DDistance(Config.CENTER.x, Config.CENTER.y, Config.CENTER.z,coords.x,coords.y,coords.z) > Config.LEAVE_FIGHT_DISTANCE then
                TriggerServerEvent('bpt_streetfight:leaveFight', GetPlayerServerId(PlayerId()))
            end
        end

        if showWinner == true and winner ~= nil then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            if get3DDistance(Config.CENTER.x, Config.CENTER.y, Config.CENTER.z,coords.x,coords.y,coords.z) < 15 then
                DrawText3D(Config.CENTER.x, Config.CENTER.y, Config.CENTER.z + 2.5, '~r~ID: ' .. winner .. ' gana!', 2.0)
            end
        end
    end
end)