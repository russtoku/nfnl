-- [nfnl] Compiled from fnl/nfnl/fs.fnl by https://github.com/Olical/nfnl, do not edit.
local autoload = require("nfnl.autoload")
local core = autoload("nfnl.core")
local str = autoload("nfnl.string")
local function basename(path)
  return vim.fn.fnamemodify(path, ":h")
end
local function file_name_root(path)
  return vim.fn.fnamemodify(path, ":r")
end
local function full_path(path)
  return vim.fn.fnamemodify(path, ":p")
end
local function mkdirp(dir)
  return vim.fn.mkdir(dir, "p")
end
local function replace_extension(path, ext)
  return (file_name_root(path) .. ("." .. ext))
end
local function read_first_line(path)
  local f = io.open(path)
  local line
  if core["table?"](f) then
    line = f:read()
  else
    line = nil
  end
  if core["table?"](f) then
    f:close()
  else
  end
  return line
end
local function relglob(dir, expr)
  local dir_len = core.inc(string.len(dir))
  local function _3_(_241)
    return string.sub(_241, dir_len)
  end
  return core.map(_3_, vim.fn.globpath(dir, expr, true, true))
end
local function glob_dir_newer_3f(a_dir, b_dir, expr, b_dir_path_fn)
  local newer_3f = false
  for _, path in ipairs(relglob(a_dir, expr)) do
    if (vim.fn.getftime((a_dir .. path)) > vim.fn.getftime((b_dir .. b_dir_path_fn(path)))) then
      newer_3f = true
    else
    end
  end
  return newer_3f
end
local path_sep
do
  local os = string.lower(jit.os)
  if (("linux" == os) or ("osx" == os) or ("bsd" == os)) then
    path_sep = "/"
  else
    path_sep = "\\"
  end
end
local function findfile(name, path)
  local res = vim.fn.findfile(name, path)
  if not core["empty?"](res) then
    return res
  else
    return nil
  end
end
local function split_path(path)
  return str.split(path, path_sep)
end
local function join_path(parts)
  return str.join(path_sep, core.concat(parts))
end
local function replace_dirs(path, from, to)
  local function _7_(segment)
    if (from == segment) then
      return to
    else
      return segment
    end
  end
  return join_path(core.map(_7_, split_path(path)))
end
return {basename = basename, ["file-name-root"] = file_name_root, ["full-path"] = full_path, mkdirp = mkdirp, ["replace-extension"] = replace_extension, relglob = relglob, ["glob-dir-newer?"] = glob_dir_newer_3f, ["path-sep"] = path_sep, findfile = findfile, ["split-path"] = split_path, ["join-path"] = join_path, ["read-first-line"] = read_first_line, ["replace-dirs"] = replace_dirs}