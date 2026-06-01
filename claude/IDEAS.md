# Claude Code — config versionada e ideas a futuro

Esta carpeta versiona **solo** la configuración portable de Claude Code.
Se enlaza con symlinks vía `make claude` (archivos individuales, nunca el
directorio `~/.claude` completo, porque ahí Claude escribe estado constante).

## Qué se versiona hoy

| Archivo en el repo | Symlink destino | Para qué |
|---|---|---|
| `claude/settings.json` | `~/.claude/settings.json` | Config global: permissions, hooks, statusline (ccstatusline), plugins (agent-skills), `env`, teammateMode. |
| `claude/scripts/block-sleep-polling.py` | `~/.claude/scripts/block-sleep-polling.py` | Hook PreToolUse que bloquea `sleep`/`until`/`while … sleep` en Bash. Referenciado por `settings.json`. |
| `claude/ccstatusline/settings.json` | `~/.config/ccstatusline/settings.json` | **Diseño de la barra de estado** (segmentos, colores, layout de ccstatusline). `settings.json` solo invoca `npx ccstatusline`; el diseño vive aquí. |

## Qué queda FUERA a propósito

- `~/.claude/settings.local.json` → allow-list local acumulada por sesión (curls/webfetch de un solo uso). Por convención `*.local.json` es local-only.
- `~/.claude.json` → auth, historial de proyectos y posibles tokens/MCP. **Nunca** al repo.
- `sessions/`, `history.jsonl`, `telemetry/`, `cache/`, `daemon*`, `projects/`, `backups/`, `plugins/cache/` → runtime puro.

## Cómo aplicar en una máquina nueva

```bash
make claude   # crea symlinks; hace backup de un settings.json previo a settings.json.dotfiles-bak
ls -l ~/.claude/settings.json   # debe apuntar a .../dotfiles/claude/settings.json
```

---

## Ideas a futuro

Cuando quiera versionar más cosas, las agrego a `claude/` y añado una línea
`$(LN_COMMAND) ...` por cada una en el target `claude` del Makefile.

- [ ] **`CLAUDE.md` global** (`~/.claude/CLAUDE.md`): instrucciones/persona por defecto para todas las sesiones (estilo de commits, idioma, convenciones). Distinto de este archivo.
- [ ] **`commands/`** (`~/.claude/commands/*.md`): slash-commands propios reutilizables entre proyectos.
- [ ] **`agents/`** (`~/.claude/agents/*.md`): subagentes personalizados.
- [ ] **`output-styles/`**: estilos de salida propios.
- [ ] **`keybindings.json`**: atajos de teclado del TUI, si los personalizo.
- [ ] **Más hooks** en `scripts/`: p. ej. formateo automático post-edición, recordatorios, validaciones de commit.
- [ ] **Separar permissions** del `settings.json`: si crece, mover el allow-list a un fragmento aparte para que el diff sea más limpio.
- [ ] **`mcp` servers declarativos**: si configuro MCP servers estables (no con secretos), versionar su declaración; los tokens van por `env`/keychain, no al repo.
- [ ] **Sección "Claude Code" en el README principal** apuntando aquí.
- [ ] **Sincronizar `enabledPlugins`/marketplaces**: hoy viven dentro de `settings.json`; revisar al actualizar agent-skills.
