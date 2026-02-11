-- ============================================================================
--  RED TEAM C++ SNIPPETS (LuaSnip)
--  Modern C++23 patterns for offensive development
-- ============================================================================

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- ──────────────────────────────────────────────────────────────
  -- xor_str: Compile-time XOR string encryption (consteval)
  -- ──────────────────────────────────────────────────────────────
  s("xor_str", {
    t({
      "template <std::size_t N>",
      "struct XorString {",
      "    char data[N];",
      "",
      "    consteval XorString(const char (&str)[N], char key = 0x55) {",
      "        for (std::size_t i = 0; i < N; ++i) {",
      "            data[i] = str[i] ^ key;",
      "        }",
      "    }",
      "",
      "    void decrypt(char key = 0x55) {",
      "        for (std::size_t i = 0; i < N; ++i) {",
      "            data[i] ^= key;",
      "        }",
      "    }",
      "};",
      "",
      "// Usage: constexpr XorString enc{\"",
    }),
    i(1, "secret string"),
    t({ "\"};" }),
  }),

  -- ──────────────────────────────────────────────────────────────
  -- span_parse: Safe byte-buffer parser using std::span
  -- ──────────────────────────────────────────────────────────────
  s("span_parse", {
    t({
      "#include <span>",
      "#include <cstdint>",
      "#include <optional>",
      "",
      "struct ",
    }),
    i(1, "Header"),
    t({
      " {",
      "    uint32_t magic;",
      "    uint32_t size;",
      "    ",
    }),
    i(2, "// additional fields"),
    t({
      "",
      "};",
      "",
      "std::optional<",
    }),
    i(3, "Header"),
    t({
      "> parse_buffer(std::span<const std::byte> buf) {",
      "    if (buf.size() < sizeof(",
    }),
    i(4, "Header"),
    t({
      ")) {",
      "        return std::nullopt;",
      "    }",
      "    ",
    }),
    i(5, "Header"),
    t({
      " hdr;",
      "    std::memcpy(&hdr, buf.data(), sizeof(hdr));",
      "    return hdr;",
      "}",
    }),
  }),

  -- ──────────────────────────────────────────────────────────────
  -- win_main: WinMain entry point template
  -- ──────────────────────────────────────────────────────────────
  s("win_main", {
    t({
      "#ifndef WIN32_LEAN_AND_MEAN",
      "#define WIN32_LEAN_AND_MEAN",
      "#endif",
      "#include <windows.h>",
      "",
      "int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,",
      "                   LPSTR lpCmdLine, int nCmdShow) {",
      "    (void)hInstance; (void)hPrevInstance;",
      "    (void)lpCmdLine; (void)nCmdShow;",
      "",
      "    ",
    }),
    i(1, "// entry point logic"),
    t({
      "",
      "",
      "    return 0;",
      "}",
    }),
  }),

  -- ──────────────────────────────────────────────────────────────
  -- print_hex: Hex dump a buffer using std::print (C++23)
  -- ──────────────────────────────────────────────────────────────
  s("print_hex", {
    t({
      "#include <print>",
      "#include <span>",
      "#include <cstdint>",
      "",
      "void print_hex(std::span<const std::uint8_t> buf) {",
      "    for (std::size_t i = 0; i < buf.size(); ++i) {",
      '        std::print("{:02x} ", buf[i]);',
      "        if ((i + 1) % 16 == 0) {",
      '            std::println("");',
      "        }",
      "    }",
      '    std::println("");',
      "}",
    }),
  }),
}
