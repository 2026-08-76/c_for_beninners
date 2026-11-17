# Programação em C: guia do aluno

**Autoria: Profº Hudson Neves**

Este guia mostra como abrir o repositório, preparar o compilador e executar o
primeiro programa. Escolha **uma** das opções abaixo:

- **GitHub Codespaces:** o compilador executa em um ambiente remoto; precisa de
  acesso ao GitHub Codespaces.
- **Windows local:** o compilador fica dentro da pasta do repositório; precisa
  de Windows 10/11 x64 e de permissão da escola para executar os programas.

## Opção 1: usar GitHub Codespaces

1. Abra a página deste repositório no GitHub:
   <https://github.com/2026-08-76/c_for_beninners>.
2. Clique em **Code** > **Codespaces** > **Create codespace on main**.
3. Aguarde o VS Code abrir no navegador. A criação do ambiente pode levar alguns
   minutos.
4. No VS Code, abra **Terminal** > **New Terminal**.
5. Pule para [Criar, compilar e executar seu programa](#criar-compilar-e-executar-seu-programa).

O Codespace já contém o compilador. A criação e o uso precisam de conexão à
internet e de permissão para usar Codespaces na conta da escola.

## Opção 2: usar GCC portátil no Windows

O script deste repositório baixa uma distribuição portátil do GCC e a extrai em
`.tools/`. Não é necessário instalar o compilador no Windows nem ter
permissões de administrador. O download acontece uma vez por clone; depois da
preparação, é possível compilar sem internet.

### A. Clonar e abrir o repositório

1. Abra a página deste repositório no GitHub.
2. Clique em **Code** > **HTTPS** e copie o endereço.
3. No VS Code, pressione `Ctrl+Shift+P`, procure **Git: Clone** e selecione o
   comando.
4. Cole o endereço copiado, escolha uma pasta para guardar o repositório e
   aguarde a clonagem.
5. Quando o VS Code perguntar, escolha **Open** para abrir a pasta clonada.

### B. Preparar o compilador com um comando

1. No VS Code, abra **Terminal** > **New Terminal**. O terminal deve ser
   PowerShell e estar na pasta principal do repositório.
2. Execute este único comando de preparação:

   ```powershell
   .\setup-gcc.ps1
   ```

3. Aguarde o download e a extração. O script verifica o SHA-256 do pacote antes
   de usá-lo. Ao terminar, deve mostrar informações de versão do GCC.

Na primeira preparação, o computador precisa estar conectado à internet e
conseguir acessar o GitHub. O compilador será guardado em
`.tools/w64devkit/`; essa pasta é local e não é enviada ao repositório.

## Criar, compilar e executar seu programa

1. No VS Code, crie um arquivo chamado **`main.c`** na pasta principal do
   repositório.
2. Cole este exemplo e salve com `Ctrl+S`:

   ```c
   #include <stdio.h>

   int main(void)
   {
       printf("Ola, mundo!\n");
       return 0;
   }
   ```

3. No terminal, compile o arquivo:

   **No Codespaces:**

   ```sh
   gcc -std=c17 -Wall -Wextra -pedantic main.c -o programa
   ```

   **No PowerShell do Windows:**

   ```powershell
   & ".\.tools\w64devkit\w64devkit\bin\gcc.exe" -std=c17 -Wall -Wextra -pedantic .\main.c -o .\programa.exe
   ```

4. Se a compilação terminar sem erros, execute o programa:

   **No Codespaces:**

   ```sh
   ./programa
   ```

   **No PowerShell do Windows:**

   ```powershell
   .\programa.exe
   ```

Você deverá ver `Ola, mundo!` no terminal. Se editar o código, salve o arquivo e
compile novamente antes de executar.

## Se algo der errado

- **O comando `.\setup-gcc.ps1` não foi encontrado:** confirme a pasta atual
  com `Test-Path .\setup-gcc.ps1`. Se o resultado for `False`, abra a pasta
  clonada no VS Code e crie um terminal novo.
- **O PowerShell bloqueou `setup-gcc.ps1` ou o download falhou:** não altere as
  configurações de segurança. Peça ajuda ao professor ou à equipe de TI.
- **A verificação do pacote falhou:** não tente executar o arquivo baixado;
  avise o professor ou a equipe de TI.
- **`main.c` não foi encontrado:** confira se o arquivo se chama exatamente
  `main.c`, está salvo e fica na pasta principal do repositório.
- **O compilador funciona, mas `programa.exe` foi bloqueado:** a equipe de TI
  também precisa permitir a execução dos programas criados pelos alunos.
- **Codespaces não aparece ou não abre:** a conta ou a rede da escola pode não
  ter acesso ao serviço. Peça orientação ao professor ou à equipe de TI.

O GCC portátil é fornecido pelo projeto
[w64devkit](https://github.com/skeeto/w64devkit).
