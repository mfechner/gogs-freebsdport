# $FreeBSD$

PORTNAME=	gogs
PORTVERSION=	0.7.19
CATEGORIES=	devel

MAINTAINER=	idefix@fechner.net
COMMENT=	A self-hosted Git service written in Go

USE_GITHUB=	yes
GH_ACCOUNT=	gogits
GH_TAGNAME=	v${PORTVERSION}

GO_PKGNAME=	github.com/${GH_ACCOUNT}/${GH_PROJECT}

USE_GCC=	yes

BUILD_DEPENDS+=	${LOCALBASE}/bin/git:${PORTSDIR}/devel/git
RUN_DEPENDS+=	${LOCALBASE}/bin/bash:${PORTSDIR}/shells/bash

OPTIONS_DEFINE=	NONE
OPTIONS_RADIO=		DATABASE WEB
OPTIONS_RADIO_DATABASE=	MYSQL SQLITE3 POSTGRESQL
OPTIONS_RADIO_WEB=	NGINX APACHE24

DATABASE_DESC=	Selection for database support
MYSQL_DESC=	MySQL Database Support
SQLITE3_DESC=	SQLite3 Database Support
POSTGRESQL_DESC=	Postgres SQL Database Support
WEB_DESC=	Webserver Support
NGINX_DESC=	Nginx support
APACHE24_DESC=	Apache24 support

OPTIONS_DEFAULT=MYSQL APACHE24
.include <bsd.port.options.mk>

# Default requirement for gogs rc script
_REQUIRE=	DAEMON NETWORKING

.if ${PORT_OPTIONS:MMYSQL}
_REQUIRE+=	mysql
.endif

.if ${PORT_OPTIONS:MPOSTGRESQL}
_REQUIRE+=	postgres
.endif

.if ${PORT_OPTIONS:MNGINX}
_REQUIRE+=	nginx
.endif

.if ${PORT_OPTIONS:MAPACHE24}
_REQUIRE+=	apache24
.endif

MYSQL_BUILD_DEPENDS=	${PREFIX}/${GO_LIBDIR}/github.com/go-sql-driver/mysql.a:${PORTSDIR}/devel/go-sql-driver
SQLITE3_BUILD_DEPENDS=	${PREFIX}/${GO_LIBDIR}/github.com/kuroneko/gosqlite3.a:${PORTSDIR}/databases/gosqlite3

do-build:
#	echo cd ${GO_WRKSRC}; ${SETENV} ${MAKE_ENV} ${GO_ENV} ${GO_CMD} get -x -v
	@(cd ${GO_WRKSRC}; ${SETENV} ${MAKE_ENV} ${GO_ENV} ${GO_CMD} get -x -v)
	@(cd ${GO_WRKSRC}; ${SETENV} ${MAKE_ENV} ${GO_ENV} ${GO_CMD} install -v ${GO_TARGET})

.include "${PORTSDIR}/lang/go/files/bsd.go.mk"
.include <bsd.port.mk>

