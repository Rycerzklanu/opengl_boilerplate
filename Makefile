
depdir := .deps
$(shell mkdir -p $(depdir) >/dev/null)
depflags = -MT $@ -MMD -MP -MF $(depdir)/$*.td

$(depdir)/%.d: ;
%.o: $(depdir)/%.d

cxx = g++
cxxflags = -Wall -Wextra -std=c++11
ldflags = -lglfw3 -lGL -ldl -lm -lX11 -lXrandr -lXinerama -lXcursor -lXi
srcdir = src
objdir = obj
includedir = include
sources = $(wildcard $(srcdir)/*.cpp) src/glad.c
objects = $(patsubst $(srcdir)/%.cpp, $(objdir)/%.o, $(sources))
executable = linux_binary

headers = $(wildcard $(includedir)/*.h)

.PHONY: all clean

all: $(executable)

$(executable): $(objects) | $(objdir)
	$(cxx) $(cxxflags) -I$(includedir) $^ -o $@ $(ldflags)

$(objdir)/%.o: $(srcdir)/%.cpp $(headers) | $(objdir)
	$(cxx) $(cxxflags) -I$(includedir) -c $< -o $@

$(objdir):
	mkdir -p $(objdir)

clean:
	rm -rf $(objdir) $(executable) $(depdir)

