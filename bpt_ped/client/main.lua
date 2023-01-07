Citizen.CreateThread(function() -- Example

  local ped_info  
  local ped_hash = 0x5B3BD90D -- Ped Hash
  local ped_coords = { x = 383.762634, y = -826.681335, z = 28.300000, h = 260.0 } -- Ped Coords
 
  RequestModel(ped_hash)
  while not HasModelLoaded(ped_hash) do
    Citizen.Wait(1)
  end
  
  ped_info = CreatePed(1, ped_hash, ped_coords.x, ped_coords.y, ped_coords.z, ped_coords.h, false, true)
  SetBlockingOfNonTemporaryEvents(ped_info, true) -- Don't Change
  SetPedDiesWhenInjured(ped_info, false) -- Can Die?
  SetPedCanPlayAmbientAnims(ped_info, true) -- Don't Change
  SetPedCanRagdollFromPlayerImpact(ped_info, false) -- Ped Fall Down
  SetEntityInvincible(ped_info, true)    -- Ped Invincible
  FreezeEntityPosition(ped_info, true) -- Don't Change
  TaskStartScenarioInPlace(ped_info, "WORLD_HUMAN_COP_IDLES", 0, true); -- Ped Anim
 
end)