.SUFFIXES: .o .cpp
CXX = g++-10
DEBUG = -g
LIB = PPP-fltk.a
INC = -I/usr/local/include -I.
DEP = Makefile.d
CXXFLAGS = $(shell fltk-config --use-gl --use-images --cxxflags) $(INC) -std=c++17 -Wall

SRCS = Simple_window.cpp GUI.cpp Graph.cpp
OBJS = $(SRCS:.cpp=.o)

# default target
all: $(OBJS)
	$(CXX) $(CFLAGS) -c $^

# $(wildcard [PATTERN]): 현재 디렉토리에서 패턴과 일치하는 파일리스트

# Generating dependency files
dep:
	$(CXX) -MM $(SRCS) > $(DEP)

# include dependency files to have g++ recompile necessary sources
ifeq ($(DEP), $(wildcard $(DEP)))
	-include %.d
endif

# $@: 현재 타겟의 이름, $<: 현재 타겟보다 일찍 변경된 종속항목 리스트
# $^: 현재 타겟의 종속항목리스트

$(LIB): $(OBJS)
	$(AR) rv $@ $(OBJS)	

%.o:  %.cpp
	$(CXX) $(CXXFLAGS) $(DEBUG) -c $< -o $@

clean:
	rm -f $(OBJS) *.o $(LIB) Makefile.d 
