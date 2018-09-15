################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../Automobile.cpp \
../Bicycle.cpp \
../Boat.cpp \
../Vehicle.cpp \
../main.cpp 

OBJS += \
./Automobile.o \
./Bicycle.o \
./Boat.o \
./Vehicle.o \
./main.o 

CPP_DEPS += \
./Automobile.d \
./Bicycle.d \
./Boat.d \
./Vehicle.d \
./main.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<" -std=gnu++14
	@echo 'Finished building: $<'
	@echo ' '


