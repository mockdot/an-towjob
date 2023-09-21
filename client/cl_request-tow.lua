if PlayerData.job.name ~= 'tow' then
    local options = {
        {
            icon = "fas fa-truck",
            label = "Solicitar grúa",
            event = "an-tow:requestTow",
            distance = 3
        },
    }
    exports.ox_target:addGlobalVehicle(options)
end

RegisterNetEvent('an-tow:requestTow')
AddEventHandler('an-tow:requestTow', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local coords = GetEntityCoords(cache.ped)
    if vehicle ~= 0 then
        TriggerServerEvent('an-tow:sendTowRequest', GetPlate(vehicle), coords)
    else
        QBCore.Functions.Notify('No vehicle found', 'error')
    end
end)

RegisterNetEvent('an-tow:requestResponse')
AddEventHandler('an-tow:requestResponse', function(towDriverName, accepted)
    if accepted then
        exports['qb-phone']:PhoneNotification('Tow request accepted by ' .. towDriverName, 'They will be there shortly!', '#9f0e63', "NONE", 5000)
    else
        exports['qb-phone']:PhoneNotification('Tow request declined.', 'Declined.', '#9f0e63', "NONE", 5000)
    end
end)

RegisterNetEvent('an-tow:receiveTowRequest')
AddEventHandler('an-tow:receiveTowRequest', function(target, plate, coords)
    exports["npwd"]:createSystemNotification({
        uniqId = "requestTow",
        content = "¿Quieres aceptar este pedido de grúa?",
        secondaryTitle = "Trabajo de Grúa",
        keepOpen = true,
        duration = 5000,
        controls = true,
        onConfirm = function()
            TriggerServerEvent('an-tow:sendTowResponse', target, true)
            local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
            SetBlipAsShortRange(blip, false)
            SetBlipSprite(blip, 68)
            SetBlipColour(blip, 0)
            SetBlipScale(blip, 0.7)
            SetBlipDisplay(blip, 6)
            Wait(130000)
            RemoveBlip(blip)
        end,
        onCancel = function()
            TriggerServerEvent('an-tow:sendTowResponse', target, false)
        end,
      })
end)
