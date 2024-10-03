obj-m += ai_inference.o

# Enable C++ compilation
CXX := g++
CXXFLAGS := -std=c++17 -fno-exceptions -fno-rtti

ifeq ($(shell uname -s),Linux)
    TARGET := ai_inference.o
    KDIR := /lib/modules/$(shell uname -r)/build
else ifeq ($(OS),Windows_NT)
    TARGET := ai_inference_win32.o
else
    $(error Unsupported operating system)
endif

all:
ifeq ($(shell uname -s),Linux)
	$(MAKE) -C $(KDIR) M=$(PWD) modules
else
	$(CXX) $(CXXFLAGS) -c ai_inference_win32.cpp -o $(TARGET)
endif

clean:
ifeq ($(shell uname -s),Linux)
    $(MAKE) -C $(KDIR) M=$(PWD) clean
else
    rm -f $(TARGET)
endif
