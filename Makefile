# $FreeBSD$

PORTNAME=	gogs
PORTVERSION=	0.5.13
CATEGORIES=	devel

MAINTAINER=	idefix@fechner.net
COMMENT=	A self-hosted Git service written in Go

USE_GITHUB=	yes
GH_ACCOUNT=	gogits
GH_TAGNAME=	v${PORTVERSION}
GH_COMMIT=	a38e4a0

GO_PKGNAME=	github.com/${GH_ACCOUNT}/${GH_PROJECT}

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

.include "${PORTSDIR}/lang/go/files/bsd.go.mk"
.include <bsd.port.mk>

