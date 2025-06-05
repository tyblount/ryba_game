function table.print(table)
    print("{")
    for key, value in pairs(table) do
        print("  " .. tostring(key) .. "=" .. tostring(value))
    end
    print("}")
end
