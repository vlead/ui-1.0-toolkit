DEST=build/
USER-DOCS=user-docs/
#SCRIPTS=scripts/
#META=meta/

all:  publish

publish: init
	emacs --script user-docs/elisp/publish.el
	rm -rf ${DEST}*~
	mv ${DEST}*.html ${DEST}${USER-DOCS}
	mv ${DEST}org-templates ${DEST}${USER-DOCS}
	mv ${DEST}style ${DEST}${USER-DOCS}
	mv ${DEST}images ${DEST}${USER-DOCS}
	rsync -raz --progress ./scripts ${DEST}
	rsync -raz --progress ./src ${DEST}


init:
	rm -rf ${DEST}
	mkdir -p ${DEST}
	mkdir -p ${DEST}${USER-DOCS}


server:
	python -m SimpleHTTPServer 6001

export:
	rsync -auvz ${DEST}presentation/* letshelp@devel.virtual-labs.ac.in:/var/www/2012-10-08-integration-sprint/

clean:
	rm -rf ${DEST}

archive:
	(cd ${DEST}; zip -r presentation.zip presentation)


