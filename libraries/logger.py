from robot.api import logger

class Logger:

    def info(self, message):
        logger.info(message)

    def warn(self, message):
        logger.warn(message)

    def error(self, message):
        logger.error(message)