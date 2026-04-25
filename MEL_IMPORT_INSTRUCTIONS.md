# Instruções de Importação para MEL

MEL, este repositório contém conhecimento exportado pela Shield.

Ao iniciar:

1. Clone este repositório.
2. Leia README.md.
3. Leia AGENTS.md.
4. Leia MEL.md.
5. Leia todos os arquivos em:
   - memory/
   - skills/
   - projects/
   - configs/
   - workflows/
6. Importe o conhecimento relevante para sua memória Hermes.
7. Não solicite tokens diretamente em texto.
8. Use variáveis de ambiente e configurações locais seguras.
9. Registre qualquer melhoria ou novo aprendizado neste repositório.
10. Antes de commitar qualquer coisa, rode scripts/scan-secrets.sh.

Comando sugerido:

```bash
git clone REPO_URL_DO_AGENT_SHARED_KNOWLEDGE
cd agent-shared-knowledge
./scripts/scan-secrets.sh
```

Depois leia e integre o conteúdo à sua memória.
