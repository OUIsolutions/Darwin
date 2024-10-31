---@param  code string
function Addccode(code)
    PrivateDarwin_include_code = PrivateDarwin_include_code .. code
end

---@param code string
function Addcinternal(code)
    PrivateDarwin_c_calls = PrivateDarwin_c_calls .. code
end
