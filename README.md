# Agent Shared Knowledge

Este repositório privado é usado para compartilhar conhecimento operacional entre dois agentes:

- Shield: agente OpenClaw/OpenCloud atual
- MEL: agente Hermes

## Objetivo

Centralizar conhecimento, histórico, skills, workflows, contexto de projetos e documentação operacional para que Shield e MEL possam trabalhar com a mesma base de informações.

## Regras

- Não armazenar tokens reais.
- Não armazenar senhas.
- Não armazenar chaves privadas.
- Não armazenar arquivos `.env` reais.
- Usar apenas arquivos sanitizados.
- Toda credencial deve ser referenciada por nome de variável de ambiente.
- Antes de commitar, rodar `./scripts/scan-secrets.sh`.

## Como usar

Shield exporta conhecimento seguro para este repositório.

MEL deve clonar este repositório, ler o conteúdo e importar o conhecimento relevante para memória, skills e contexto operacional.
