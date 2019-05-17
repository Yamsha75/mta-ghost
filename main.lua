GHOST_KEY = 'x'

function updateZ()
    local velocity = localVehicle.velocity
    velocity.z = z
    localVehicle.velocity = velocity
end

function toggleGhost(bool)
    enabled = bool
    if enabled then
        z = localVehicle.velocity.z
        addEventHandler('onClientRender', root, updateZ)
    else
        removeEventHandler('onClientRender', root, updateZ)
    end
    triggerServerEvent('onClientToggleGhost', localVehicle)
    setCameraClip(not enabled, not enabled)
end

function handleGhostKey(key, keyState)
    if localVehicle then
        if not enabled and keyState == 'down' then
            toggleGhost(true)
        elseif enabled and keyState == 'up' then
            toggleGhost(false)
        end
    end
end

function newVehicle(vehicle, seat)
    if seat == 0 then
        localVehicle = vehicle
        addEventHandler('onClientVehicleExplode', localVehicle, noVehicle)
        addEventHandler('onClientElementDestroy', localVehicle, noVehicle)
        addEventHandler('onClientVehicleStartExit', localVehicle, noVehicle)

    end
end
addEventHandler('onClientPlayerVehicleEnter', localPlayer, newVehicle)

function noVehicle()
    removeEventHandler('onClientVehicleExplode', localVehicle, noVehicle)
    removeEventHandler('onClientElementDestroy', localVehicle, noVehicle)
    removeEventHandler('onClientVehicleStartExit', localVehicle, noVehicle)
    if enabled then
        toggleGhost(false)
    end
    localVehicle = nil
end

function resourceStart()
    if localPlayer.vehicle then
        newVehicle(localPlayer.vehicle, localPlayer.vehicleSeat)
    end
    bindKey(GHOST_KEY, 'both', handleGhostKey)
end
addEventHandler('onClientResourceStart', resourceRoot, resourceStart)

function resourceStop()
    if localVehicle and enabled then
        toggleGhost(false)
    end
end
addEventHandler('onClientResourceStop', resourceRoot, resourceStop)