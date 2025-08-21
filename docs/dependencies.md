# Dependencies & Licenses

Darwin uses only open-source dependencies, all compatible with commercial use. You can:
- Use Darwin commercially
- Distribute Darwin-compiled programs
- Modify Darwin
- Include Darwin in proprietary projects

---
## Core Dependencies

### Lua Programming Language
- License: MIT ([link](https://lua.org/))
- Source: https://lua.org/
- Description: Fast, lightweight, simple syntax, extensible, mature.

<details>
<summary>Full Lua License Text</summary>

```
Lua is free software distributed under the terms of the MIT license 
reproduced here. Lua may be used for any purpose, including commercial 
purposes, at absolutely no cost. No paperwork, no royalties, no GNU-like 
"copyleft" restrictions, either. Just download it and use it.

Lua is certified Open Source software. Its license is simple and liberal 
and is compatible with GPL. Lua is not in the public domain and PUC-Rio 
keeps its copyright.

The spirit of the Lua license is that you are free to use Lua for any 
purpose at no cost without having to ask us. The only requirement is 
that if you do use Lua, then you should give us credit by including 
the copyright notice somewhere in your product or its documentation.
```

</details>

---
## Integration Libraries

### LuaCEmbed
- License: MIT ([link](https://github.com/OUIsolutions/LuaCEmbed))
- Source: https://github.com/OUIsolutions/LuaCEmbed
- Description: Bridge between Lua and C, memory safe, high performance, easy API.

<details>
<summary>LuaCEmbed License (MIT)</summary>

```
MIT License

Copyright (c) 2024 Mateus Moutinho Queiroz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

</details>

---
## Built-in Library Ecosystem

### LuaDoTheWorld
- License: MIT ([link](https://github.com/OUIsolutions/LuaDoTheWorld))
- Source: https://github.com/OUIsolutions/LuaDoTheWorld
- Description: File and system operations, cross-platform.

<details>
<summary>LuaDoTheWorld License (MIT)</summary>

```
MIT License

Copyright (c) 2024 OUI

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

</details>

### DoTheWorld (C Library)
- License: MIT ([link](https://github.com/OUIsolutions/DoTheWorld))
- Source: https://github.com/OUIsolutions/DoTheWorld
- Description: Core system operations, low-level file handling, cross-platform, optimized.

<details>
<summary>DoTheWorld License (MIT)</summary>

```
MIT License

Copyright (c) 2023 Mateus Moutinho Queiroz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

</details>

---
## JSON & Data Processing

### cJSON
- License: MIT ([link](https://github.com/DaveGamble/cJSON))
- Source: https://github.com/DaveGamble/cJSON
- Description: Fast JSON parsing/generation, robust, lightweight.

<details>
<summary>cJSON License (MIT)</summary>

```
MIT License

Copyright (c) 2009-2017 Dave Gamble and cJSON contributors

Permission is hereby granted, free of charge, to any person obtaining a copy 
of this software and associated documentation files (the "Software"), to deal 
in the Software without restriction, including without limitation the rights 
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
copies of the Software, and to permit persons to whom the Software is 
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE.
```

</details>

---
## Security & Cryptography

### SHA-256
- License: 0BSD ([link](https://github.com/amosnier/sha-2))
- Source: https://github.com/amosnier/sha-2
- Description: Secure hash algorithm for data integrity, file integrity, verification, security features.

<details>
<summary>SHA-256 License (Zero Clause BSD)</summary>

```
Zero Clause BSD License
© 2021 Alain Mosnier

Permission to use, copy, modify, and/or distribute this software for any 
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES 
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR 
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES 
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF 
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

</details>

---
## License Compatibility Matrix

| License | Commercial Use | Redistribution | Modification | Patent Grant | Copyleft |
|---------|---------------|----------------|--------------|--------------|----------|
| MIT     | Yes           | Yes            | Yes          | No           | No       |
| 0BSD    | Yes           | Yes            | Yes          | No           | No       |

**Summary:**
- Commercial use allowed
- Closed source allowed
- No royalties
- Attribution recommended for redistribution
- Worldwide, perpetual rights

---
## Contributing Back

Ways to help:
- Star the [Darwin repository](https://github.com/OUIsolutions/Darwin)
- Report bugs, suggest features, improve documentation, submit pull requests
- Support and contribute to dependencies (Lua, LuaCEmbed, LuaDoTheWorld, cJSON, crypto libraries)

---
## License FAQ

- Can I use Darwin in commercial products? **Yes.**
- Do I need to share my source code? **No.**
- Can I modify Darwin and keep changes private? **Yes.**
- Do I need to include license notices? **Recommended for redistribution.**
- Can I sell Darwin-compiled programs? **Yes.**

For legal questions, consult a lawyer or read the full license texts above.

---
## Hall of Fame

Special thanks to the developers of these libraries:

| Project      | Maintainer           | Country   | Fun Fact                      |
|--------------|----------------------|-----------|-------------------------------|
| Lua          | PUC-Rio Team         | Brazil    | Created for oil exploration   |
| LuaCEmbed    | Mateus Queiroz       | Brazil    | Powers Darwin's core magic    |
| LuaDoTheWorld| OUI Solutions        | Brazil    | Makes file ops a breeze       |
| cJSON        | Dave Gamble          | Global    | Used by millions of projects  |
| SHA-256      | Alain Mosnier        | Global    | Keeps your data secure        |

---

Thank you to all open source contributors who make Darwin possible!

Back: [Build Guide](build.md) | Home: [Main README](../README.md)
