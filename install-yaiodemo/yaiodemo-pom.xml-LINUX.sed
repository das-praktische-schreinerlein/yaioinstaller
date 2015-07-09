s/^ *<karmaExecutable>.*/                    <karmaExecutable>${basedir}\/node_modules\/karma\/bin\/karma<\/karmaExecutable>/
s/^ *<protractor>.*/                    <protractor>${basedir}\/node_modules\/.bin\/protractor<\/protractor>/
s/^ *<exec executable="cmd.exe"><arg value="\/C" \/><arg value="\$\{basedir\}\/sbin\/stop-yaioapp.bat" \/><\/exec>.*/                                <exec executable="\/bin\/bash"><arg value="${basedir}\/sbin\/stop-yaioapp.sh" \/><\/exec>/
s/^ *<exec executable="cmd.exe"><arg value="\/C" \/><arg value="\$\{basedir\}\/sbin\/start-yaioapp-test.bat" \/><\/exec>.*/                                <exec executable="\/bin\/bash"><arg value="${basedir}\/sbin\/start-yaioapp.sh" \/><\/exec>/
s/^ *<exec executable="cmd.exe"><arg value="\/C" \/><arg value="\$\{basedir\}\/sbin\/stop-yaioapp.bat" \/><\/exec>.*/                                <exec executable="\/bin\/bash"><arg value="${basedir}\/sbin\/stop-yaioapp.sh" \/><\/exec>/
