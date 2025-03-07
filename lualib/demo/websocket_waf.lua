local ip = ngx.var.remote_addr
local dict = ngx.shared.ip_block_list

-- ################################### IP段检测 ################################# --
-- local iputils = require("resty.iputils")
-- -- 允许访问的白名单 IP 和 IP 段
-- local whitelist_ips = {
--     "223.243.243.0/24",         -- 单个IP
--     "203.0.113.0/24",      -- IP段 (CIDR格式)
--     "10.0.0.0/16"          -- IP段 (CIDR格式)
-- }
--
-- -- 解析CIDR范围
-- local whitelist_cidrs = iputils.parse_cidrs(whitelist_ips)
--
-- -- 检查IP是否在白名单中
-- if iputils.ip_in_cidrs(ip, whitelist_cidrs) then
--     ngx.log(ngx.ERR, "Whitelisted IP allowed: ", ip)
--     return
-- end
-- ################################### IP段检测 ################################# --

-- 检查 IP 是否被封禁
local is_blocked = dict:get(ip)
if is_blocked then
    ngx.log(ngx.ERR, "Blocked IP: ", ip)
    ngx.exit(403)
end

-- ################################### 检查来路域名是否允许################################# --
-- local referer = ngx.var.http_referer
-- local allowed_domains = {"example.com", "anotherdomain.com"}  -- 允许的来路域名列表
-- local is_valid_referer = false
-- if referer then
--     for _, domain in ipairs(allowed_domains) do
--         if referer:find(domain) then
--             is_valid_referer = true
--             break
--         end
--     end
-- end
-- -- 如果 Referer 或 Origin 不合法，拒绝请求
-- if not is_valid_referer then
--     ngx.log(ngx.ERR, "Invalid referer from: ", ip)
--     ngx.exit(403)
-- end
-- ################################### 检查来路域名是否允许################################# --

-- ################################### 检查 Origin 是否允许################################# --
local origin = ngx.var.http_origin
-- 允许的 Origin 域名列表
local allowed_origins = {
    "https://baidu.com",
}
local is_valid_origin = false
if origin then
    for _, valid_origin in ipairs(allowed_origins) do
        if origin == valid_origin then
            is_valid_origin = true
            break
        end
    end
end

-- 如果 Referer 或 Origin 不合法，拒绝请求
if not is_valid_origin then
    ngx.log(ngx.ERR, "Invalid origin from: ", ip)
    ngx.exit(403)
end

-- ################################### 检查 Origin 是否允许################################# --

-- ################################### 检查是否是 WebSocket 请求 ################################# --
local upgrade = ngx.var.http_upgrade
if not upgrade or upgrade:lower() ~= "websocket" then
    ngx.log(ngx.ERR, "Non-websocket request from: ", ip)
    -- 把 IP 加入封禁列表，设置 10 分钟（600 秒）
    dict:set(ip, true, 600)

    ngx.exit(403)
end
-- ################################### 检查是否是 WebSocket 请求 ################################# --