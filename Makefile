obj-m += ai_inference.o

# Enable C++ compilation
CXX := g++
CXXFLAGS := -std=c++17 -fno-exceptions -fno-rtti

ifeq ($(shell uname -s),Linux)
    TARGET := ai_inference.o
else ifeq ($(OS),Windows_NT)
    TARGET := ai_inference_win32.o
else
    $(error Unsupported operating system)
endif

all:
ifeq ($(shell uname -s),Linux)
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
else ifeq ($(OS),Windows_NT)
	$(CXX) $(CXXFLAGS) -c ai_inference_win32.cpp -o $(TARGET)
endif

clean:
ifeq ($(shell uname -s),Linux)
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
else ifeq ($(OS),Windows_NT)
	rm -f $(TARGET)
endif