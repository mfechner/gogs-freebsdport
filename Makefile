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

OPTIONS_DEFINE=	MYSQL SQLITE3
MYSQL_DESC=	MySQL Database Support
SQLITE3_DESC=	SQLite3 Database Support
#POSTGRESQL_DESC=	Postgres SQL Database Support

OPTIONS_DEFAULT=MYSQL
MYSQL_BUILD_DEPENDS=	${PREFIX}/${GO_LIBDIR}/github.com/go-sql-driver/mysql.a:${PORTSDIR}/devel/go-sql-driver
SQLITE3_BUILD_DEPENDS=	${PREFIX}/${GO_LIBDIR}/github.com/kuroneko/gosqlite3.a:${PORTSDIR}/databases/gosqlite3

.include <bsd.port.options.mk>
.include "${PORTSDIR}/lang/go/files/bsd.go.mk"
.include <bsd.port.mk>

