-- MySQL Script generated by MySQL Workbench
-- MySQL Workbench Forward Engineering


-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS mydb;
CREATE SCHEMA IF NOT EXISTS mydb DEFAULT CHARACTER SET utf8 ;
USE mydb;

-- -----------------------------------------------------
-- Table `Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome completo` VARCHAR(45) NULL,
  `contato` CHAR(10) NULL,
  `perfil` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Nome completo_UNIQUE` (`Nome completo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cartao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cartao` (
  `idCartao` INT NOT NULL AUTO_INCREMENT,
  `Cliente_idCliente` INT NOT NULL,
  `tipo_cartao` ENUM('credito', 'debito') NOT NULL,
  `nome_titular` VARCHAR(50) NOT NULL,
  `numero` BIGINT(16) NOT NULL,
  `data_validade` VARCHAR(5) NOT NULL,
  `codigo_seguranca` INT NOT NULL,
  `bandeira` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idCartao`),
  UNIQUE INDEX `uc_Cartao_numero_tipo_cartao` (`numero` ASC, `tipo_cartao` ASC) VISIBLE,
  CONSTRAINT `cartao_cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Cliente_idCliente` INT NOT NULL,
  `Descrição` VARCHAR(255) NULL,
  `Título do pedido` VARCHAR(45) NULL,
  `Tipo de problema` ENUM('Software', 'Hardware') NULL,
  `Prioridade` ENUM('Baixa', 'Média', 'Alta') NULL DEFAULT 'Baixa',
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`),
  INDEX `fk_Pedido_Cliente2_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente2`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Categoria` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(45) NULL,
  `Valor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `Razao_Social` VARCHAR(45) NULL,
  `CNPJ` CHAR(15) NOT NULL,
  `contato` VARCHAR(45) NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Produto_fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Produto_fornecedor` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idProduto`),
  INDEX `fk_Fornecedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Produto_Fornecedor_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Estoque` (
  `idEstoque` INT NOT NULL,
  `Local` VARCHAR(45) NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Produto_Estoque_Localizacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Produto_Estoque_Localizacao` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Localizacao` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Produto/pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Produto_pedido` (
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Quantidade` VARCHAR(45) NOT NULL,
  `Status` ENUM('disponível', 'sem estoque') NULL DEFAULT 'disponível',
  PRIMARY KEY (`Produto_idProduto`, `Pedido_idPedido`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Terceiro_Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Terceiro_Vendedor` (
  `idTerceiro_Vendedor` INT NOT NULL AUTO_INCREMENT,
  `Razao_Social` VARCHAR(45) NOT NULL COMMENT 'constrain',
  `Local` VARCHAR(45) NULL,
  `Nome_Fantasia` VARCHAR(45) NULL,
  `CNPJ` CHAR(15) NULL,
  `CPF` CHAR(9) NULL,
  PRIMARY KEY (`idTerceiro_Vendedor`),
  UNIQUE INDEX `Razão Social_UNIQUE` (`Razao_Social` ASC) VISIBLE,
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Produtos_vendedor_Terceiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Produtos_vendedor_Terceiro` (
  `idPseller` INT NOT NULL AUTO_INCREMENT,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`idPseller`, `Produto_idProduto`),
  INDEX `fk_Terceiro - Vendedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Terceiro - Vendedor_has_Produto_Terceiro - Vendedor1_idx` (`idPseller` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro - Vendedor_has_Produto_Terceiro - Vendedor1`
    FOREIGN KEY (`idPseller`)
    REFERENCES `Terceiro_Vendedor` (`idTerceiro_Vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro - Vendedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome completo` VARCHAR(45) NULL,
  `contato` CHAR(10) NULL,
  `perfil` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Nome completo_UNIQUE` (`Nome completo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Cliente_idCliente` INT NOT NULL,
  `Descrição` VARCHAR(255) NULL,
  `Título do pedido` VARCHAR(45) NULL,
  `Tipo de problema` ENUM('Software', 'Hardware') NULL,
  `Prioridade` ENUM('Baixa', 'Média', 'Alta') NULL DEFAULT 'Baixa',
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`),
  INDEX `fk_Pedido_Cliente2_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente2`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Responsável`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Responsável` (
  `idResponsável` INT NOT NULL,
  `Setor` VARCHAR(45) NULL,
  `Matrícula` VARCHAR(45) NULL,
  `Cargo` VARCHAR(45) NULL,
  PRIMARY KEY (`idResponsável`),
  UNIQUE INDEX `Matrícula_UNIQUE` (`Matrícula` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pedido_gerado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pedido_gerado` (
  `Pedido_idPedido` INT NOT NULL,
  `Responsável_idResponsável` INT NOT NULL,
  `Setor responsável` VARCHAR(45) NULL DEFAULT 'Help desk',
  `Comentários` VARCHAR(45) NULL,
  `Setor encaminhado` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Responsável_idResponsável`),
  INDEX `fk_Pedido_has_Responsável_Responsável1_idx` (`Responsável_idResponsável` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Responsável_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Responsável_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Responsável_Responsável1`
    FOREIGN KEY (`Responsável_idResponsável`)
    REFERENCES `Responsável` (`idResponsável`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ordem de Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ordem de Serviço` (
  `idOrdem de Serviço` INT NOT NULL,
  `Descrição` VARCHAR(45) NULL,
  `Prioridade` VARCHAR(45) NULL,
  `Pedido_has_Responsável_Pedido_idPedido` INT NOT NULL,
  `Pedido_has_Responsável_Responsável_idResponsável` INT NOT NULL,
  PRIMARY KEY (`idOrdem de Serviço`),
  INDEX `fk_Ordem de Serviço_Pedido_has_Responsável1_idx` (`Pedido_has_Responsável_Pedido_idPedido` ASC, `Pedido_has_Responsável_Responsável_idResponsável` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Serviço_Pedido_has_Responsável1`
    FOREIGN KEY (`Pedido_has_Responsável_Pedido_idPedido` , `Pedido_has_Responsável_Responsável_idResponsável`)
    REFERENCES `Pedido_gerado` (`Pedido_idPedido` , `Responsável_idResponsável`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Entrega` (
  `idStatus` INT NOT NULL,
  `Status` ENUM('Em andamento', 'Enviado', 'Entregue') NOT NULL,
  `Codigo_Rastreio` VARCHAR(20) NULL,
  `Pedido_idPedido` INT NULL,
  `status_data` DATETIME NULL,
  `IdEntrega` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_Entrega_Pedido_idPedido_idx` (`Pedido_idPedido` ASC) VISIBLE,
  PRIMARY KEY (`IdEntrega`),
  CONSTRAINT `fk_Entrega_Pedido_idPedido`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

