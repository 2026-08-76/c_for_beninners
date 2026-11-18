# Como compilar e executar um programa em C no Windows

**Autor: Profº Hudson Neves**

Este guia mostra como preparar o GCC, entender o arquivo `main.c`, criar um
arquivo `.exe` e executar o programa no Windows usando o CMD.

## 1. Abra a pasta do projeto no CMD

No VS Code, abra a pasta do projeto e escolha **Terminal > Novo Terminal**.
Se o terminal não estiver usando o CMD, abra um prompt de comando e entre na
pasta do projeto:

```cmd
cd /d "C:\caminho\para\c_for_beninners-main"
```

Use o caminho onde você salvou o projeto. O terminal deve estar na pasta que
contém os arquivos `main.c` e `setup-gcc.ps1`.

## 2. Prepare o GCC (apenas na primeira vez)

O computador precisa estar conectado à internet durante a instalação. No CMD,
execute:

```cmd
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\setup-gcc.ps1"
```

O script baixa o GCC portátil, verifica o arquivo e instala o compilador dentro
da pasta `.tools` do projeto. Essa opção não altera permanentemente a política
de execução do PowerShell.

Para confirmar a instalação:

```cmd
".\.tools\w64devkit\w64devkit\bin\gcc.exe" --version
```

## 3. Entenda o arquivo `main.c`

O arquivo `main.c` é o código-fonte do programa. Ele já existe na pasta do
projeto e contém este exemplo:

```c
#include <stdio.h>

int main(void)
{
    printf("Ola, mundo!\n");
    return 0;
}
```

A explicação das partes principais é:

- `#include <stdio.h>` inclui a biblioteca padrão de entrada e saída, necessária
  para usar `printf`.
- `int main(void)` declara a função principal do programa. É por ela que o
  sistema operacional começa a execução.
- `{` e `}` delimitam o corpo da função `main`.
- `printf("Ola, mundo!\n");` escreve a mensagem no terminal. `\n` faz o cursor
  passar para a próxima linha.
- `return 0;` informa ao sistema operacional que o programa terminou sem erros.

Edite o conteúdo entre as chaves de `main` e salve o arquivo com `Ctrl+S`. Cada
vez que alterar `main.c`, será necessário compilá-lo novamente para gerar uma
nova versão do `.exe`.

## 4. Compile `main.c` para criar o `.exe`

Confirme que `main.c` está na pasta principal do projeto. No CMD, execute:

```cmd
if not exist build mkdir build
".\.tools\w64devkit\w64devkit\bin\gcc.exe" -std=c17 -Wall -Wextra -pedantic ".\main.c" -o ".\build\programa.exe"
```

Se a compilação terminar sem erros, o executável estará em
`build\programa.exe`.

Os parâmetros ajudam a controlar a compilação:

- `-std=c17` usa o padrão C17 da linguagem C.
- `-Wall -Wextra -pedantic` ativa avisos úteis para encontrar problemas no
  código.
- `main.c` é o arquivo-fonte que será compilado.
- `-o build\programa.exe` define o nome e a pasta do programa criado.

## 5. Execute o programa

No CMD, execute:

```cmd
.\build\programa.exe
```

A saída esperada é:

```text
Ola, mundo!
```

## 6. Atualize o programa depois de editar

Sempre siga esta sequência:

1. Abra e edite `main.c`.
2. Salve o arquivo com `Ctrl+S`.
3. Execute novamente o comando de compilação.
4. Execute `build\programa.exe`.

Não abra diretamente `main.c` como se fosse um programa; ele é texto-fonte e
precisa ser compilado pelo GCC para virar um executável.

## Resolução de problemas

- **`main.c` não foi encontrado:** confirme que o arquivo se chama exatamente
  `main.c`, está salvo e fica na pasta principal do projeto.
- **`setup-gcc.ps1` não foi encontrado:** confirme a pasta atual com
  `dir setup-gcc.ps1`. Se o arquivo não aparecer, entre na pasta do projeto
  novamente.
- **O PowerShell bloqueou o script ou o download falhou:** não altere
  permanentemente as configurações de segurança do computador. Procure ajuda do
  professor ou da equipe de TI.
- **A verificação do pacote falhou:** não execute o arquivo baixado; avise o
  professor ou a equipe de TI.
- **O executável foi bloqueado:** a equipe de TI pode precisar permitir a
  execução dos programas criados pelos alunos.

O GCC portátil é fornecido pelo projeto
[w64devkit](https://github.com/skeeto/w64devkit).
