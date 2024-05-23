#include "StaffSystem/LoginDriver.h"
#include "StaffSystem/SystemDriver.h"
#include "StaffSystem/StaffDriver.h"

#include <QApplication>
#include <QCommandLineParser>
#include <QDir>
#include <QFileInfo>
#include <QFont>
#include <QQmlApplicationEngine>
#include <QQmlExtensionPlugin>
#include <QQuickWindow>
#include <QStandardPaths>
#include <QPalette>

int main(int argc, char* argv[])
{
	QQuickWindow::setGraphicsApi(QSGRendererInterface::Direct3D11Rhi);

	QApplication app(argc, argv);

	// change current working directory to executable folder to be able to load resources files
	if (QDir::setCurrent(QCoreApplication::applicationDirPath()) == false)
		qFatal("failed to change current working directory to executable folder");

	app.setOrganizationName("Siemens");
	app.setApplicationName("SiemensStaffSystem");
	app.setFont(QFont("Roboto"));

	QColor windowColor = QColor(45, 45, 45);
	QColor textColor = Qt::white;

	QPalette palette;
	palette.setColor(QPalette::Window, windowColor);
	palette.setColor(QPalette::WindowText, textColor);
	app.setPalette(palette);

	QQmlApplicationEngine engine;

	engine.addImportPath("qrc:/");

	// initialize login driver
	auto loginDriver = engine.singletonInstance<client::system::LoginDriver*>("StaffSystem", "LoginDriver");
	Q_UNUSED(loginDriver)

	// initialize staff driver
	auto staffDriver = engine.singletonInstance<client::system::StaffDriver*>("StaffSystem", "StaffDriver");
	staffDriver->init();

	// initialize main driver
	auto systemDriver = engine.singletonInstance<client::system::SystemDriver*>("StaffSystem", "SystemDriver");
	systemDriver->setAppRef(&app);

	QObject::connect(
		&engine,
		&QQmlApplicationEngine::objectCreated,
		&app,
		[systemDriver](QObject* object, const QUrl& url) {
			if (object == nullptr)
				QApplication::exit(-1);
		},
		Qt::QueuedConnection
	);

	engine.load(QUrl(u"qrc:/StaffSystem/resources/main.qml"_qs));

	return app.exec();
}