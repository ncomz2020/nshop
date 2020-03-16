package com.ncomz.nshop.schedule;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.ncomz.nshop.service.common.FileService;

public class ExpiredFileMonitor extends QuartzJobBean {

	private FileService fileService = null;
	
	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		// TODO Auto-generated method stub
		try {
			this.fileService.deleteExpiredTempFiles();
		} catch (Exception ex) {
			ex.printStackTrace();
			JobExecutionException jee = new JobExecutionException(ex);
			jee.setUnscheduleAllTriggers(false);
			jee.setUnscheduleFiringTrigger(false);
			throw jee;
		}
	}
	
	
	
}
