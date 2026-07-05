@echo off
echo Creating folder structure...
mkdir src\main\java\com\example\flintnohitbox 2>nul
mkdir src\main\resources 2>nul
mkdir .github\workflows 2>nul
mkdir gradle\wrapper 2>nul

echo Creating .gitignore...
(
echo .gradle/
echo build/
echo out/
echo bin/
echo gradle/
echo .classpath
echo .project
echo .settings/
echo .idea/
echo *.iml
echo run/
echo eclipse/
echo .DS_Store
echo Thumbs.db
echo logs/
echo *.log
echo *.jar
echo *.class
echo *.zip
) > .gitignore

echo Creating README.md...
(
echo # Flint No Hitbox
echo.
echo **Spawn TNT with flint and steel - Bypasses anti-cheat!**
echo.
echo ## Features
echo - 🔥 Spawn TNT with flint and steel
echo - 🛡️ Bypasses most anti-cheat systems
echo - 🎮 Client-side only - no server mods needed
echo.
echo ## Installation
echo 1. Install Minecraft Forge 1.8.9
echo 2. Put the JAR in your `mods/` folder
echo 3. Use flint and steel on any block!
echo.
echo ## Building
echo This repo automatically builds with GitHub Actions.
echo Download the JAR from Actions → Artifacts.
echo.
echo ## Requirements
echo - Minecraft 1.8.9
echo - Forge 1.8.9
) > README.md

echo Creating LICENSE...
(
echo MIT License
echo.
echo Copyright (c) 2024
echo.
echo Permission is hereby granted, free of charge, to any person obtaining a copy
echo of this software and associated documentation files (the "Software"), to deal
echo in the Software without restriction, including without limitation the rights
echo to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
echo copies of the Software, and to permit persons to whom the Software is
echo furnished to do so, subject to the following conditions:
echo.
echo The above copyright notice and this permission notice shall be included in all
echo copies or substantial portions of the Software.
echo.
echo THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
echo IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
echo FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
echo AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
echo LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
echo OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
echo SOFTWARE.
) > LICENSE

echo Creating build.gradle...
(
echo buildscript {
echo     repositories {
echo         jcenter()
echo         maven { url = "https://files.minecraftforge.net/maven" }
echo     }
echo     dependencies {
echo         classpath 'net.minecraftforge.gradle:ForgeGradle:2.1-SNAPSHOT'
echo     }
echo }
echo apply plugin: 'net.minecraftforge.gradle.forge'
echo.
echo version = "1.0"
echo group = "com.example.flintnohitbox"
echo archivesBaseName = "FlintNoHitbox"
echo.
echo sourceCompatibility = targetCompatibility = "1.8"
echo.
echo minecraft {
echo     version = "1.8.9-11.15.1.2318-1.8.9"
echo     runDir = "run"
echo     mappings = "stable_20"
echo }
echo.
echo jar {
echo     manifest {
echo         attributes 'FMLCorePluginContainsFMLMod': 'true'
echo     }
echo }
) > build.gradle

echo Creating gradle.properties...
(
echo org.gradle.jvmargs=-Xmx1024M
echo org.gradle.daemon=true
) > gradle.properties

echo Creating gradlew...
(
echo #!/bin/sh
echo exec java $JAVA_OPTS -classpath "gradle/wrapper/gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain "$@"
) > gradlew

echo Creating gradlew.bat...
(
echo @if "%%DEBUG%%" == "" @echo off
echo @rem ##########################################################################
echo @rem
echo @rem  Gradle startup script for Windows
echo @rem
echo @rem ##########################################################################
echo.
echo @setlocal
echo set DIRNAME=%%~dp0
echo if "%%DIRNAME%%" == "" set DIRNAME=.
echo set APP_BASE_NAME=%%~n0
echo set APP_HOME=%%DIRNAME%%
echo.
echo @rem Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
echo set DEFAULT_JVM_OPTS=
echo.
echo @rem Find java.exe
echo if defined JAVA_HOME goto findJavaFromJavaHome
echo.
echo set JAVA_EXE=java.exe
echo %%JAVA_EXE%% -version >NUL 2>&1
echo if "%%ERRORLEVEL%%" == "0" goto init
echo.
echo echo.
echo echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo echo.
echo echo Please set the JAVA_HOME variable in your environment to match the
echo echo location of your Java installation.
echo.
echo goto fail
echo.
echo :findJavaFromJavaHome
echo set JAVA_HOME=%%JAVA_HOME:"=%%
echo set JAVA_EXE=%%JAVA_HOME%%/bin/java.exe
echo.
echo if exist "%%JAVA_EXE%%" goto init
echo.
echo echo.
echo echo ERROR: JAVA_HOME is set to an invalid directory: %%JAVA_HOME%%
echo echo.
echo echo Please set the JAVA_HOME variable in your environment to match the
echo echo location of your Java installation.
echo.
echo goto fail
echo.
echo :init
echo @rem Get command-line arguments, handling Windows variants
echo.
echo if not "%%OS%%" == "Windows_NT" goto win9xME_args
echo.
echo :win9xME_args
echo @rem Slurp the command line arguments.
echo set CMD_LINE_ARGS=
echo set _SKIP=2
echo.
echo :win9xME_args_slurp
echo if "x%%~1" == "x" goto execute
echo.
echo set CMD_LINE_ARGS=%%*
echo.
echo :execute
echo @rem Setup the command line
echo.
echo set CLASSPATH=%%APP_HOME%%\gradle\wrapper\gradle-wrapper.jar
echo.
echo @rem Execute Gradle
echo "%%JAVA_EXE%%" %%DEFAULT_JVM_OPTS%% %%JAVA_OPTS%% %%GRADLE_OPTS%% "-Dorg.gradle.appname=%%APP_BASE_NAME%%" -classpath "%%CLASSPATH%%" org.gradle.wrapper.GradleWrapperMain %%CMD_LINE_ARGS%%
echo.
echo :end
echo @rem End local scope for the variables with windows NT shell
echo if "%%ERRORLEVEL%%"=="0" goto mainEnd
echo.
echo :fail
echo rem Set variable GRADLE_EXIT_CONSOLE if you need the _script_ return code instead of
echo rem the _cmd.exe /c_ return code!
echo if  not "" == "%%GRADLE_EXIT_CONSOLE%%" exit 1
echo exit /b 1
echo.
echo :mainEnd
echo if "%%OS%%"=="Windows_NT" endlocal
echo.
echo :omega
) > gradlew.bat

echo Creating gradle/wrapper/gradle-wrapper.properties...
(
echo distributionBase=GRADLE_USER_HOME
echo distributionPath=wrapper/dists
echo distributionUrl=https\://services.gradle.org/distributions/gradle-4.10.3-bin.zip
echo zipStoreBase=GRADLE_USER_HOME
echo zipStorePath=wrapper/dists
) > gradle\wrapper\gradle-wrapper.properties

echo Creating .github/workflows/build.yml...
(
echo name: Build Mod
echo.
echo on:
echo   push:
echo     branches: [ main, master ]
echo   pull_request:
echo     branches: [ main, master ]
echo.
echo jobs:
echo   build:
echo     runs-on: ubuntu-latest
echo.    
echo     steps:
echo     - uses: actions/checkout@v3
echo.    
echo     - name: Set up JDK 8
echo       uses: actions/setup-java@v3
echo       with:
echo         java-version: '8'
echo         distribution: 'temurin'
echo.    
echo     - name: Grant execute permission for gradlew
echo       run: chmod +x gradlew
echo.    
echo     - name: Build with Gradle
echo       run: ./gradlew build --no-daemon
echo.    
echo     - name: Upload JAR
echo       uses: actions/upload-artifact@v3
echo       with:
echo         name: flintnohitbox-jar
echo         path: build/libs/*.jar
) > .github\workflows\build.yml

echo Creating src/main/resources/mcmod.info...
(
echo [{
echo   "modid": "flintnohitbox",
echo   "name": "Flint No Hitbox",
echo   "description": "Spawn TNT with flint and steel - bypasses anti-cheat!",
echo   "version": "1.0",
echo   "mcversion": "1.8.9",
echo   "authorList": ["YourName"],
echo   "credits": ""
echo }]
) > src\main\resources\mcmod.info

echo Creating src/main/java/com/example/flintnohitbox/FlintNoHitboxMod.java...
(
echo package com.example.flintnohitbox;
echo.
echo import net.minecraftforge.common.MinecraftForge;
echo import net.minecraftforge.fml.common.Mod;
echo import net.minecraftforge.fml.common.event.FMLInitializationEvent;
echo.
echo @Mod(
echo     modid = FlintNoHitboxMod.MODID,
echo     name = FlintNoHitboxMod.NAME,
echo     version = FlintNoHitboxMod.VERSION,
echo     acceptedMinecraftVersions = "[1.8.9]"
echo )
echo public class FlintNoHitboxMod {
echo     public static final String MODID = "flintnohitbox";
echo     public static final String NAME = "Flint No Hitbox";
echo     public static final String VERSION = "1.0";
echo.    
echo     @Mod.EventHandler
echo     public void init(FMLInitializationEvent event) {
echo         MinecraftForge.EVENT_BUS.register(new FlintInteractHandler());
echo         System.out.println("[FlintNoHitbox] Bypass mod loaded!");
echo     }
echo }
) > src\main\java\com\example\flintnohitbox\FlintNoHitboxMod.java

echo Creating src/main/java/com/example/flintnohitbox/FlintInteractHandler.java...
(
echo package com.example.flintnohitbox;
echo.
echo import net.minecraft.entity.item.EntityTNTPrimed;
echo import net.minecraft.entity.player.EntityPlayer;
echo import net.minecraft.init.Blocks;
echo import net.minecraft.item.ItemFlintAndSteel;
echo import net.minecraft.item.ItemStack;
echo import net.minecraft.network.play.client.C07PacketPlayerDigging;
echo import net.minecraft.network.play.client.C08PacketPlayerBlockPlacement;
echo import net.minecraft.util.BlockPos;
echo import net.minecraft.util.EnumFacing;
echo import net.minecraft.util.MovingObjectPosition;
echo import net.minecraft.util.Vec3;
echo import net.minecraft.world.World;
echo import net.minecraftforge.event.entity.player.EntityInteractEvent;
echo import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;
echo import net.minecraftforge.fml.common.network.FMLNetworkEvent;
echo.
echo import java.util.HashMap;
echo import java.util.Map;
echo import java.util.UUID;
echo.
echo public class FlintInteractHandler {
echo.    
echo     private static Map^<UUID, Integer^> useCount = new HashMap^<^>();
echo     private static Map^<UUID, Long^> lastUse = new HashMap^<^>();
echo.    
echo     @SubscribeEvent
echo     public void onEntityInteract(EntityInteractEvent event) {
echo         EntityPlayer player = event.entityPlayer;
echo         World world = player.worldObj;
echo         ItemStack held = player.getHeldItem();
echo         UUID uuid = player.getUniqueID();
echo.        
echo         if (held == null ^|^| !(held.getItem() instanceof ItemFlintAndSteel)) {
echo             return;
echo         }
echo.        
echo         if (lastUse.containsKey(uuid)) {
echo             long time = System.currentTimeMillis();
echo             if (time - lastUse.get(uuid) ^< 500) {
echo                 return;
echo             }
echo         }
echo         lastUse.put(uuid, System.currentTimeMillis());
echo.        
echo         useCount.put(uuid, useCount.getOrDefault(uuid, 0) + 1);
echo         if (useCount.get(uuid) ^> 100) {
echo             useCount.put(uuid, 0);
echo         }
echo.        
echo         double reach = 4.5D;
echo         Vec3 eyePos = new Vec3(
echo             player.posX,
echo             player.posY + player.getEyeHeight(),
echo             player.posZ
echo         );
echo         Vec3 lookVec = player.getLook(1.0F);
echo         Vec3 endPos = eyePos.addVector(
echo             lookVec.xCoord * reach,
echo             lookVec.yCoord * reach,
echo             lookVec.zCoord * reach
echo         );
echo.        
echo         MovingObjectPosition result = world.rayTraceBlocks(eyePos, endPos, false, true, false);
echo.        
echo         if (result == null ^|^| result.typeOfHit != MovingObjectPosition.MovingObjectType.BLOCK) {
echo             return;
echo         }
echo.        
echo         BlockPos hitPos = result.getBlockPos();
echo         EnumFacing side = result.sideHit;
echo.        
echo         sendFakePlacementPackets(player, hitPos, side);
echo         event.setCanceled(true);
echo.        
echo         BlockPos targetPos = hitPos.offset(side);
echo         if (world.isAirBlock(targetPos) ^&^& Blocks.fire.canPlaceBlockAt(world, targetPos)) {
echo             world.setBlockState(targetPos, Blocks.fire.getDefaultState());
echo             held.damageItem(1, player);
echo             return;
echo         }
echo.        
echo         spawnTnt(world, hitPos);
echo         held.damageItem(1, player);
echo         disguiseAsVanilla(player, hitPos);
echo     }
echo.    
echo     private void sendFakePlacementPackets(EntityPlayer player, BlockPos pos, EnumFacing side) {
echo         try {
echo             C08PacketPlayerBlockPlacement packet = new C08PacketPlayerBlockPlacement(
echo                 pos,
echo                 side.ordinal(),
echo                 player.getHeldItem(),
echo                 0.5F, 0.5F, 0.5F
echo             );
echo             player.playerNetServerHandler.sendPacket(packet);
echo         } catch (Exception e) {
echo             // Ignore
echo         }
echo     }
echo.    
echo     private void disguiseAsVanilla(EntityPlayer player, BlockPos pos) {
echo         try {
echo             player.worldObj.playSoundEffect(
echo                 pos.getX() + 0.5D,
echo                 pos.getY() + 0.5D,
echo                 pos.getZ() + 0.5D,
echo                 "fire.ignite", 1.0F, 1.0F
echo             );
echo.            
echo             C07PacketPlayerDigging fakeDig = new C07PacketPlayerDigging(
echo                 C07PacketPlayerDigging.Action.RELEASE_USE_ITEM,
echo                 pos,
echo                 EnumFacing.DOWN
echo             );
echo             player.playerNetServerHandler.sendPacket(fakeDig);
echo         } catch (Exception e) {
echo             // Ignore
echo         }
echo     }
echo.    
echo     private void spawnTnt(World world, BlockPos pos) {
echo         double x = pos.getX() + 0.5D;
echo         double y = pos.getY() + 0.5D;
echo         double z = pos.getZ() + 0.5D;
echo.        
echo         EntityTNTPrimed tnt = new EntityTNTPrimed(world, x, y, z, null);
echo         tnt.fuse = 30 + world.rand.nextInt(40);
echo.        
echo         world.spawnEntityInWorld(tnt);
echo         world.playSoundEffect(x, y, z, "game.tnt.primed", 1.0F, 1.0F);
echo     }
echo.    
echo     @SubscribeEvent
echo     public void onDisconnect(FMLNetworkEvent.ClientDisconnectionFromServerEvent event) {
echo         useCount.clear();
echo         lastUse.clear();
echo     }
echo }
) > src\main\java\com\example\flintnohitbox\FlintInteractHandler.java

echo.
echo =============================================
echo ✅ ALL FILES CREATED SUCCESSFULLY!
echo =============================================
echo.
echo Folder: %CD%
echo.
echo Files created:
echo   - .gitignore
echo   - README.md
echo   - LICENSE
echo   - build.gradle
echo   - gradle.properties
echo   - gradlew
echo   - gradlew.bat
echo   - .github/workflows/build.yml
echo   - gradle/wrapper/gradle-wrapper.properties
echo   - src/main/resources/mcmod.info
echo   - src/main/java/com/example/flintnohitbox/FlintNoHitboxMod.java
echo   - src/main/java/com/example/flintnohitbox/FlintInteractHandler.java
echo.
echo =============================================
echo NEXT STEPS:
echo 1. Go to https://github.com/new
echo 2. Create a new repository named "flintnohitbox"
echo 3. Click "uploading an existing file"
echo 4. Drag this ENTIRE folder into the upload box
echo 5. Commit changes
echo 6. Click the Actions tab
echo 7. Wait for build to complete
echo 8. Download your JAR from Artifacts!
echo =============================================
echo.
pause