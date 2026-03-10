CC := gcc

SRC_DIR := src
INCLUDE_DIR := include
BUILD_DIR := build
DEBUG_DIR := $(BUILD_DIR)/debug
RELEASE_DIR := $(BUILD_DIR)/release

LIBNAME := libfcyrt.a

SRCS := $(wildcard $(SRC_DIR)/*.c)

OBJS_DEBUG := $(patsubst $(SRC_DIR)/%.c,$(DEBUG_DIR)/%.o,$(SRCS))
OBJS_RELEASE := $(patsubst $(SRC_DIR)/%.c,$(RELEASE_DIR)/%.o,$(SRCS))

# Compiler flags
CFLAGS_COMMON := -std=c11 -Wall -Wextra -I$(INCLUDE_DIR) -lm
CFLAGS_DEBUG := $(CFLAGS_COMMON) -g -O0 -DDEBUG
CFLAGS_RELEASE := $(CFLAGS_COMMON) -O2 -DNDEBUG

# Default target
all: release

# Debug build
debug: $(DEBUG_DIR)/$(LIBNAME)

$(DEBUG_DIR)/$(LIBNAME): $(OBJS_DEBUG)
	@mkdir -p $(DEBUG_DIR)
	ar rcs $@ $^

$(DEBUG_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(DEBUG_DIR)
	$(CC) $(CFLAGS_DEBUG) -c $< -o $@

# Release build
release: $(RELEASE_DIR)/$(LIBNAME)

$(RELEASE_DIR)/$(LIBNAME): $(OBJS_RELEASE)
	@mkdir -p $(RELEASE_DIR)
	ar rcs $@ $^

$(RELEASE_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(RELEASE_DIR)
	$(CC) $(CFLAGS_RELEASE) -c $< -o $@

# Clean build artifacts
.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)

.PHONY: install
install: $(RELEASE_DIR)/$(LIBNAME)
	mkdir -p ~/.fency/runtime/
	cp $< ~/.fency/runtime/
