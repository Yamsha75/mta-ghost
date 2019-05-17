local ghostVehicles = {}

function isGhostEnabled(vehicle)
    for _, val in ipairs(ghostVehicles) do
        if val == vehicle then
            return true
        end
    end
    return false
end

function toggleGhost(vehicle, enabled)
    vehicle.collisions = not enabled
    if enabled then
        table.insert(ghostVehicles, vehicle)
    else
        for key, val in ipairs(ghostVehicles) do
            if vehicle == val then
                table.remove(ghostVehicles, key)
                break
            end
        end
    end
end

addEvent('onClientToggleGhost', true)
function toggleClientGhost()
    if client.vehicle == source and client.vehicleSeat == 0 then
        enabled = not isGhostEnabled(source)
        toggleGhost(source, enabled)
    end
end
addEventHandler('onClientToggleGhost', root, toggleClientGhost)

function resourceStop()
    for _, vehicle in ipairs(ghostVehicles) do
        toggleGhost(vehicle, false)
    end
end
addEventHandler('onResourceStop', resourceRoot, resourceStop)