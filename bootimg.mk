# Definições de caminho e destino
MKBOOTIMG := device/samsung/a71/mkbootimg
FLASH_IMAGE_TARGET ?= $(PRODUCT_OUT)/recovery.tar

# Compilação do boot image
$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES) $(BOOTIMAGE_EXTRA_DEPS)
	$(call pretty,"Criando imagem de inicialização: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) echo -n "SEANDROIDENFORCE" >> $@
	@echo "Imagem de inicialização criada: $@"

# Compilação da imagem de recuperação
$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) $(recovery_ramdisk) $(recovery_kernel) $(RECOVERYIMAGE_EXTRA_DEPS)
	@echo "----- Criando imagem de recuperação ------"
	$(hide) $(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	@echo "----- Modificando estado do SEAndroid para o bootloader da Samsung ------"
	$(hide) echo -n "SEANDROIDENFORCE" >> $@
	@echo "Imagem de recuperação criada: $@"
	$(hide) tar -C $(PRODUCT_OUT) -c recovery.img > $(FLASH_IMAGE_TARGET)
	@echo "Criado $(FLASH_IMAGE_TARGET) flashável: $@"
