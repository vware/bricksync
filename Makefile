CC ?= gcc
CFLAGS += -std=gnu99 -O2 -s -fvisibility=hidden
LDLIBS += -lm -lpthread -lssl -lcrypto

OBJ=obj
BIN=bin
DTA=data
SRC_FILES = bricksync.c bricksyncconf.c bricksyncnet.c bricksyncinit.c bricksyncinput.c bsantidebug.c bsmessage.c bsmathpuzzle.c bsorder.c bsregister.c bsapihistory.c bstranslation.c bsevalgrade.c bsoutputxml.c bsorderdir.c bspriceguide.c bsmastermode.c bscheck.c bssync.c bsapplydiff.c bsfetchorderinv.c bsresolve.c bscatedit.c bsfetchinv.c bsfetchorderlist.c bsfetchset.c bscheckreg.c bsfetchpriceguide.c tcp.c vtlex.c cpuinfo.c antidebug.c mm.c mmhash.c mmbitmap.c cc.c ccstr.c debugtrack.c tcphttp.c oauth.c bricklink.c brickowl.c brickowlinv.c colortable.c json.c bsx.c bsxpg.c journal.c exclperm.c iolog.c crypthash.c cryptsha1.c rand.c bn512.c bn1024.c rsabn.c
OBJ_FILES = $(SRC_FILES:%.c=$(OBJ)/%.o)

bricksync: $(OBJ_FILES)
	@mkdir -p $(BIN)
	@echo Link $^ with $(LDLIBS)
	@$(CC) $(CFLAGS) $^ -o $(BIN)/$@ $(LDLIBS) 
 
$(OBJ_FILES): $(OBJ)/%.o: %.c
	@mkdir -p $(@D)
	@echo Compile $<
	@$(CC) $(CFLAGS) -c $< -o $@

install: bricksync
	@mkdir -p $(DESTDIR)/$(DTA)
	@echo Install into $(DESTDIR)
	@cp $(BIN)/bricksync $(DESTDIR)/
	@cp bricksync.conf.txt $(DESTDIR)/$(DTA)

.PHONY: clean

clean:
	@rm -rf $(BIN)
	@rm -rf $(OBJ)
