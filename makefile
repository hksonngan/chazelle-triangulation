CXX=clang++
BOOST=-I/usr/local/boost_1_58_0
CXXFLAGS=-g -O0 -std=c++1z -c
OBJS := main.o lipton-tarjan.o
.DEFAULT_GOAL = all

-include $(OBJS:.o=.d)

all: lt erdos-renyi

lt: $(OBJS)
	$(CXX) $(OBJS) -o lt

erdos-renyi: erdos-renyi.o
	$(CXX) erdos-renyi.o -o erdos-renyi

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(BOOST) $*.cpp
	@$(CXX) -MM $(CXXFLAGS) $(BOOST) $*.cpp > $*.d
	@cp -f $*.d $*.d.tmp
	@sed -e 's/.*://' -e 's/\\$$//' < $*.d.tmp | fmt -1 | \
	  sed -e 's/^ *//' -e 's/$$/:/' >> $*.d
	@rm -f $*.d.tmp 

clean:
	rm -f *.o *.d lt
