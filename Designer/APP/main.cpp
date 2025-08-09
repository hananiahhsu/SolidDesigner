#include <helpers/loglog.h>
#include <log4cplus/initializer.h>
#include "UiApplicationImpl/AliceUiApplicationProxy.h"
#include "AliceNew.h"
#include "AliceIApplicationProxyManager.h"
#include "AliceTransferOwnership.h"
#include "AliceDebugMessage.h"

using namespace log4cplus::helpers;
using namespace alice;
int main(int argc, char *argv[])
{
    IApplicationProxyManager* pProxyMgr = IApplicationProxyManager::Get();
    DBG_WARN_AND_RETURN_UNLESS(pProxyMgr, -1, L"pProxyMgr is null", L"hananiah", L"2023.08.27");

    alice::IApplicationProxy* pApp = pProxyMgr->CreateApplicationProxy(argc, argv);
    DBG_WARN_AND_RETURN_UNLESS(pApp, -1, L"pApp is null", L"hananiah", L"2023.08.27");
    int nResult = pApp->Execute();
    return nResult;
    return 0;
}


/*

#if 0
log4cplus::Initializer initializer;
LogLog::getLogLog()->debug(LOG4CPLUS_TEXT("The log has been added inside..."));
//CCreateDump::Instance()->DeclarDumpFile("dumpfile");
QApplication a(argc, argv);

//! 系统初始化（注册表）
QCoreApplication::setOrganizationName("SolidEditor");
QCoreApplication::setApplicationName("SolidEditor");
QCoreApplication::setApplicationVersion("1.1.0-alpha");
QFileInfo prgInfo(QFile::decodeName(argv[0]));
QString prgDir(prgInfo.absolutePath());
SE_SETTINGS->init(a.organizationName(), a.applicationName());
SE_SYSTEM->init(a.applicationName(), a.applicationVersion(), "SolidEditor", prgDir);

//！创建主窗口
MainWindow w;
//！磁盘目录解析
QCommandLineParser parser;
parser.setApplicationDescription("Qt Dir View Example");
parser.addHelpOption();
parser.addVersionOption();
QCommandLineOption dontUseCustomDirectoryIconsOption("c", "Set QFileIconProvider::DontUseCustomDirectoryIcons");
parser.addOption(dontUseCustomDirectoryIconsOption);
parser.addPositionalArgument("directory", "The directory to start in.");
parser.process(a);
const QString rootPath = parser.positionalArguments().isEmpty()
? QString() : parser.positionalArguments().first();

if (parser.isSet(dontUseCustomDirectoryIconsOption))
w.mDirModel.iconProvider()->setOptions(QFileIconProvider::DontUseCustomDirectoryIcons);
w.getRootPath(rootPath);




//w.show();
w.showMaximized();
return a.exec();
#endif

*/
