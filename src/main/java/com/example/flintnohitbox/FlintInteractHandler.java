package com.example.flintnohitbox;

import net.minecraft.entity.item.EntityTNTPrimed;
import net.minecraft.entity.player.EntityPlayer;
import net.minecraft.init.Blocks;
import net.minecraft.item.ItemFlintAndSteel;
import net.minecraft.item.ItemStack;
import net.minecraft.network.play.client.C07PacketPlayerDigging;
import net.minecraft.network.play.client.C08PacketPlayerBlockPlacement;
import net.minecraft.util.BlockPos;
import net.minecraft.util.EnumFacing;
import net.minecraft.util.MovingObjectPosition;
import net.minecraft.util.Vec3;
import net.minecraft.world.World;
import net.minecraftforge.event.entity.player.EntityInteractEvent;
import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;
import net.minecraftforge.fml.common.network.FMLNetworkEvent;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class FlintInteractHandler {
    
    private static Map<UUID, Integer> useCount = new HashMap<>();
    private static Map<UUID, Long> lastUse = new HashMap<>();
    
    @SubscribeEvent
    public void onEntityInteract(EntityInteractEvent event) {
        EntityPlayer player = event.entityPlayer;
        World world = player.worldObj;
        ItemStack held = player.getHeldItem();
        UUID uuid = player.getUniqueID();
        
        if (held == null || !(held.getItem() instanceof ItemFlintAndSteel)) {
            return;
        }
        
        if (lastUse.containsKey(uuid)) {
            long time = System.currentTimeMillis();
            if (time - lastUse.get(uuid) < 500) {
                return;
            }
        }
        lastUse.put(uuid, System.currentTimeMillis());
        
        useCount.put(uuid, useCount.getOrDefault(uuid, 0) + 1);
        if (useCount.get(uuid) > 100) {
            useCount.put(uuid, 0);
        }
        
        double reach = 4.5D;
        Vec3 eyePos = new Vec3(
            player.posX,
            player.posY + player.getEyeHeight(),
            player.posZ
        );
        Vec3 lookVec = player.getLook(1.0F);
        Vec3 endPos = eyePos.addVector(
            lookVec.xCoord * reach,
            lookVec.yCoord * reach,
            lookVec.zCoord * reach
        );
        
        MovingObjectPosition result = world.rayTraceBlocks(eyePos, endPos, false, true, false);
        
        if (result == null || result.typeOfHit != MovingObjectPosition.MovingObjectType.BLOCK) {
            return;
        }
        
        BlockPos hitPos = result.getBlockPos();
        EnumFacing side = result.sideHit;
        
        sendFakePlacementPackets(player, hitPos, side);
        event.setCanceled(true);
        
        BlockPos targetPos = hitPos.offset(side);
        if (world.isAirBlock(targetPos) && Blocks.fire.canPlaceBlockAt(world, targetPos)) {
            world.setBlockState(targetPos, Blocks.fire.getDefaultState());
            held.damageItem(1, player);
            return;
        }
        
        spawnTnt(world, hitPos);
        held.damageItem(1, player);
        disguiseAsVanilla(player, hitPos);
    }
    
    private void sendFakePlacementPackets(EntityPlayer player, BlockPos pos, EnumFacing side) {
        try {
            C08PacketPlayerBlockPlacement packet = new C08PacketPlayerBlockPlacement(
                pos,
                side.ordinal(),
                player.getHeldItem(),
                0.5F, 0.5F, 0.5F
            );
            player.playerNetServerHandler.sendPacket(packet);
        } catch (Exception e) {
            // Ignore
        }
    }
    
    private void disguiseAsVanilla(EntityPlayer player, BlockPos pos) {
        try {
            player.worldObj.playSoundEffect(
                pos.getX() + 0.5D,
                pos.getY() + 0.5D,
                pos.getZ() + 0.5D,
                "fire.ignite", 1.0F, 1.0F
            );
            
            C07PacketPlayerDigging fakeDig = new C07PacketPlayerDigging(
                C07PacketPlayerDigging.Action.RELEASE_USE_ITEM,
                pos,
                EnumFacing.DOWN
            );
            player.playerNetServerHandler.sendPacket(fakeDig);
        } catch (Exception e) {
            // Ignore
        }
    }
    
    private void spawnTnt(World world, BlockPos pos) {
        double x = pos.getX() + 0.5D;
        double y = pos.getY() + 0.5D;
        double z = pos.getZ() + 0.5D;
        
        EntityTNTPrimed tnt = new EntityTNTPrimed(world, x, y, z, null);
        tnt.fuse = 30 + world.rand.nextInt(40);
        
        world.spawnEntityInWorld(tnt);
        world.playSoundEffect(x, y, z, "game.tnt.primed", 1.0F, 1.0F);
    }
    
    @SubscribeEvent
    public void onDisconnect(FMLNetworkEvent.ClientDisconnectionFromServerEvent event) {
        useCount.clear();
        lastUse.clear();
    }
}
